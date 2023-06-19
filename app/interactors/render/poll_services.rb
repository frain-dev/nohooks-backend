module Render
  class PollService < ApplicationInteractor
    def call 
      @account = context.account
      @client = RenderRuby::Client.new(api_key: @account.api_key)
      services = retrieve_account_services(@account)
      
      return if services.empty?
  
      services.each do |service|
        service = service.service
        computed_hash = compute_service_hash(service)

        db_service = RenderService.find_by_service_id(service.id)
        if db_service.nil? 
          send_service_created_event(service, computed_hash)
          next
        end
  
        if computed_hash != db_service.object_hash 
          send_service_updated_event(db_service, service, computed_hash)
        end
      end
    end
  
    private
  
    def retrieve_account_services(cursor: nil) 
      services = client.services.list(limit: 100, cursor: cursor)
      if services.total == 0
        return services.data
      end

      return services.data.concat(retrieve_account_services(services.next_cursor))
    end
  
    def compute_service_hash(service)
      Digest::SHA256.hexdigest(service.to_h.to_json)
    end
  
    def send_service_created_event(service, hash)
      ActiveRecord::Base.transaction do 
        RenderService.create(account: @account, service_id: service.id, object_hash: hash)
        Webhook.create(event_type: "service.created", payload: service.to_h)
      end
    end
  
    def send_service_updated_event(db_service, service, hash)
      ActiveRecord::Base.transaction do
        update = db_service.update(object_hash: hash)
        Webhook.create(event_type: "service.updated", payload: service.to_h)
      end
    end
  end
end