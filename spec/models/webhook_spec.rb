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
#  account_id :uuid
#
# Indexes
#
#  index_webhooks_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require 'rails_helper'

RSpec.describe Webhook, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
