class PollNotionResourcesJob < ApplicationJob
  queue_as :notion_poller
  discard_on StandardError

  def perform(account_id)
    account = Account.find(account_id)

    Notion::PollDatabases.call(account: account)
  end
end
