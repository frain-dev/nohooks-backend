class PushWebhooksToConvoyJob < ApplicationJob
  queue_as :push_webhooks

  def perform
    #pubsub = Google::Cloud::PubSub.new(
    #  project_id: "unofficial-webhooks",
    #  credentials: "~/Downloads/unofficial-webhooks-publisher-key.json"
    #)

    ## Retrieve a topic
    #topic = pubsub.topic "unofficial-webhooks-staging"

    Webhook.where(status: :pending).each do |webhook|
      # Use Convoy Client to push event. 
    end
  end

  private

  def generate_webhook_payload(webhook)
    {
      event_type: webhook.event_type,
      data: webhook.payload
    }.to_json
  end
end
