class PollDigitalOceanResourcesJob < ApplicationJob
  queue_as :digital_ocean_poller
  discard_on StandardError

  def perform(account_id)
    account = Account.find_by!(id: account_id)

    DigitalOcean::PollDroplets.call(account: account)
  end
end
