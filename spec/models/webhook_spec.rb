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
require 'rails_helper'

RSpec.describe Webhook, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
