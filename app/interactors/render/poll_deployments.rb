module Render
  class PollDeployments < ApplicationInteractor
    def call
      @account = context.account
      @client = RenderRuby::Client.new(api_key: @account.configurable.api_key)
      @services = @account.render_services

      @services.each do |service|
        deployments = retrieve_account_deployments(service)
        next if deployments.empty?

        deployments.each do |deployment|
          deployment = deployment.deploy
          computed_hash = compute_deployment_hash(deployment)
          db_deployment = RenderDeployment.find_by_deployment_id(deployment.id)

          if db_deployment.nil?
            send_deployment_created_event(service, deployment, computed_hash)
            next
          end

          if computed_hash != db_deployment.object_hash
            send_deployment_status_event(db_deployment, deployment, computed_hash)
          end
        end
      end
    end
  
    private 
  
    def retrieve_account_deployments(service, cursor: nil)
      deployments = @client.deploys.list(service_id: service.service_id, 
                                         limit: 100, cursor: cursor)
      if deployments.total == 0
        return deployments.data
      end

      return deployments.data.concat(
        retrieve_account_deployments(service, cursor: deployments.next_cursor))
    end
  
    def compute_deployment_hash(deployment)
      Digest::SHA256.hexdigest(deployment.to_h.to_json)
    end
  
    def send_deployment_created_event(render_service, deployment, hash)
      ActiveRecord::Base.transaction do
        RenderDeployment.create!(render_service: render_service, 
                                deployment_id: deployment.id, object_hash: hash)
        Webhook.create!(account: @account, 
                        event_type: "deployment.created", payload: deployment.to_h)
      end
    end
  
    def send_deployment_status_event(db_deployment, deployment, hash)
      case deployment.status
      when "live"
        event_type = "deployment.live"
      when "canceled"
        event_type = "deployment.canceled"
      when "deactivated"
        event_type = "deployment.deactivated"
      when "build_failed", "update_failed"
        event_type = "deployment.failed"
      else
        event_type = "deployment.updated" 
      end 

      ActiveRecord::Base.transaction do
        update = db_deployment.update!(object_hash: hash)
        Webhook.create!(account: @account, 
                        event_type: event_type, payload: deployment.to_h)
      end
    end
  end
end
