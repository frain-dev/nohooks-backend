class PushWebhookToConvoyJob < ApplicationJob
  class PushError < StandardError; end

  queue_as :push_webhooks
  retry_on PushError, wait: :exponentially_longer, attempts: 10

  def perform(webhook_id)
    webhook = Webhook.find(webhook_id)
    return if webhook.sent?

    # Use Convoy Client to push event. 
    event = Convoy::Event.new(
              data: {
                owner_id: webhook.account_id,
                idempotency_key: webhook.id,
                event_type: webhook.event_type,
                data: generate_webhook_payload(webhook)
              }
    )

    res = event.fanout
    raise PushError.new res&.response['message'] if res&.response.nil? || 
      res&.response['status'] == false

    webhook.update!(status: :sent)
  end

  private

  def generate_webhook_payload(webhook)
    {
      event_type: webhook.event_type,
      data: webhook.payload
    }
  end
end
