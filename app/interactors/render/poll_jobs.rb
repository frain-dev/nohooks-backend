module Render
  class PollJobs < ApplicationInteractor
    def call 
      @account = context.account
      @client = RenderRuby::Client.new(api_key: @account.configurable.api_key)
      @services = @account.render_services

      @services.each do |service|
        jobs = retrieve_account_jobs(service)
        next if jobs.empty?

        jobs.each do |job|
          job = job.job
          computed_hash = compute_job_hash(job)
          db_job = RenderJob.find_by_job_id(job.id)

          if db_job.nil?
            send_job_created_event(service, job, computed_hash)
            next
          end

          if computed_hash != db_job.object_hash
            send_job_status_event(db_job, job, computed_hash)
          end
        end
      end
    end

    private

    def retrieve_account_jobs(service, cursor: nil)
      jobs = @client.jobs.list(service_id: service.service_id,
                               limit: 100, cursor: cursor)
      if jobs.total == 0 
        return jobs.data
      end

      return jobs.data.concat(retrieve_account_jobs(service, jobs.next_cursor))
    end

    def compute_job_hash(job)
      Digest::SHA256.hexdigest(job.to_h.to_json)
    end

    def send_job_created_event(render_service, job, hash)
      ActiveRecord::Base.transaction do
        RenderJob.create!(render_service: render_service,
                          job_id: job.id, object_hash: hash)
        Webhook.create!(account: @account,
                        event_type: "job.created", payload: job.to_h)
      end
    end

    def send_job_status_event(db_job, job, hash)
      ActiveRecord::Base.transaction do 
        update = db_job.update!(object_hash: hash)
        Webhook.create!(account: @account,
                        event_type: "job.updated", payload: job.to_h)
      end
    end
  end
end
