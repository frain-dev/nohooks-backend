module Render
  class PollServices < ApplicationInteractor
    def call 
      @account = context.account
      @client = RenderRuby::Client.new(api_key: @account.configurable.api_key)

      services = retrieve_account_services      
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

      deleted_services = retrieve_deleted_services(services)
      return if deleted_services.empty?

      deleted_services.each do |db_service|
        send_service_deleted_event(db_service)
      end

    end
  
    private
  
    def retrieve_account_services(cursor: nil) 
      services = @client.services.list(limit: 100, cursor: cursor)
      if services.total == 0
        return services.data
      end

      return services.data.concat(retrieve_account_services(cursor: services.next_cursor))
    end

    def retrieve_deleted_services(services)
      account_services = RenderService.where(account: @account).pluck(:service_id)
      render_services = services.map {|s| s.service.id }
      deleted_services = account_services - render_services
      RenderService.where(service_id: deleted_services)
    end
  
    def compute_service_hash(service)
      Digest::SHA256.hexdigest(service.to_h.to_json)
    end
  
    def send_service_created_event(service, hash)
      ActiveRecord::Base.transaction do 
        RenderService.create!(account: @account, service_id: service.id, object_hash: hash)
        Webhook.create!(account: @account, event_type: "service.created", payload: service.to_h)
      end
    end
  
    def send_service_updated_event(db_service, service, hash)
      case service.suspended
      when "suspended"
        event_type = "service.suspended"
      when "not_suspended"
        event_type = "service.live"
      else
        event_type = "service.updated"
      end

      ActiveRecord::Base.transaction do
        update = db_service.update!(object_hash: hash)
        Webhook.create!(account: @account, event_type: event_type, payload: service.to_h)
      end
    end

    def send_service_deleted_event(db_service)
      payload = {
        id: db_service.service_id
      }
      ActiveRecord::Base.transaction do 
        Webhook.create!(account: @account, event_type: "service.deleted", payload: payload)
        db_service.destroy!
      end
    end
  end
end
