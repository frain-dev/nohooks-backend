class PollRenderResourcesJob < ApplicationJob
  queue_as :render_poller

  def perform(account_id)
    account = Account.find(account_id)

    #Render::PollJobs.call(account: account)
    #Render::PollServices.call(account: account)
    Render::PollDeployments.call(account: account)
  end
end
