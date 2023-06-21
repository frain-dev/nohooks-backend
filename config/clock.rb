# frozen_string_literal: true

require 'clockwork'
require 'active_support/time'
require './config/boot'
require './config/environment'

module Clockwork
  handler do |job|
    job.camelize.constantize.perform_later
  end

  poll_interval = ENV['POLL_INTERVAL'].to_i.seconds
  every(poll_interval, 'poll_accounts_job')

  push_webhooks_interval = ENV['PUSH_WEBHOOKS_INTERVAL'].to_i.seconds
  every(push_webhooks_interval, 'push_webhooks_job')
end
