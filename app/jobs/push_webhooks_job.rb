class PushWebhooksJob < ApplicationJob
  queue_as :webhooks_delivery_scheduler

  def perform(*args)
    Webhook.where(status: :pending).each do |webhook|
      PushWebhookToConvoyJob.perform_later(webhook.id)
    end
  end
end
