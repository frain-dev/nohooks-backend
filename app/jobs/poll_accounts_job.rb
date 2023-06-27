class PollAccountsJob < ApplicationJob
  queue_as :render_scheduler

  def perform(*args)
    Account.active.each do |account|
      poll_account(account)
    end
  end

  private

  def poll_account(account)
    case account.configurable_type
    when "RenderAccountConfiguration"
      PollRenderResourcesJob.perform_later(account.id)
    when "NotionAccountConfiguration"
      PollNotionResourcesJob.perform_later(account.id)
    when "DigitalOceanAccountConfiguration"
      PollDigitalOceanResourcesJob.perform_later(account.id)
    end
  end
end
