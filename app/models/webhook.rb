# == Schema Information
#
# Table name: webhooks
#
#  id         :uuid             not null, primary key
#  event_type :string           not null
#  payload    :json             not null
#  status     :integer          default("pending")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Webhook < ApplicationRecord
  STATUSES = { pending: 0, sent: 1 }.freeze
  enum status: STATUSES
end
