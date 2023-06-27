module DigitalOcean
  class PollDroplets < ApplicationInteractor
    def call 
      @account = context.account 
      @client = DropletKit::Client.new(access_token: @account.configurable.access_token)

      return if @account.configurable_type != "DigitalOceanAccountConfiguration"

      droplets = retrieve_account_droplets

      droplets.each do |droplet|
        computed_hash = compute_droplet_hash(droplet)

        db_droplet = DigitalOceanDroplet.find_by_droplet_id(droplet.id)
        if db_droplet.nil?
          send_droplet_created_event(droplet, computed_hash)
          next
        end

        if computed_hash != db_droplet.object_hash
          send_droplet_updated_event(db_droplet, droplet, computed_hash)
        end
      end

      deleted_droplets = retrieve_deleted_droplets(droplets)
      return if deleted_droplets.empty?

      deleted_droplets.each do |db_droplet|
        send_droplet_deleted_event(db_droplet)
      end

    rescue StandardError => e
      fail_context_to_sentry!(error: e)
    end

    private

    def retrieve_account_droplets
      @client.droplets.all
    end

    def retrieve_deleted_droplets(droplets)
      account_droplets = DigitalOceanDroplet.where(account: @account).pluck(:droplet_id)
      digital_ocean_droplets = retrieve_account_droplets.map(&:id)
      deleted_droplets = account_droplets - digital_ocean_droplets
      DigitalOceanDroplet.where(droplet_id: deleted_droplets)
    end

    def compute_droplet_hash(droplet)
      Digest::SHA256.hexdigest(droplet.to_h.to_json)
    end

    def send_droplet_created_event(droplet, hash)
      ActiveRecord::Base.transaction do 
        binding.pry
        DigitalOceanDroplet.create!(account: @account, 
                                    droplet_id: droplet.id, object_hash: hash)
        Webhook.create!(account: @account, 
                        event_type: "droplet.created", payload: droplet.to_h)
      end
    end

    def send_droplet_updated_event(db_droplet, droplet, hash)
      case droplet.status
      when "off"
        event_type = "droplet.off"
      when "archive"
        event_type = "droplet.archived"
      when "active"
        event_type = "droplet.updated"
      end

      ActiveRecord::Base.transaction do 
        update = db_droplet.update!(object_hash: hash)
        Webhook.create!(account: @account, event_type: event_type, payload: droplet.to_h)
      end
    end

    def send_droplet_deleted_event(db_droplet)
      payload = {
        id: db_droplet.droplet_id
      }

      ActiveRecord::Base.transaction do 
        Webhook.create!(account: @account, event_type: "droplet.deleted", payload: payload)
        db_droplet.destroy!
      end
    end
  end
end
