# == Schema Information
#
# Table name: digital_ocean_droplets
#
#  id          :uuid             not null, primary key
#  object_hash :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :uuid
#  droplet_id  :string           not null
#
# Indexes
#
#  index_digital_ocean_droplets_on_account_id                 (account_id)
#  index_digital_ocean_droplets_on_account_id_and_droplet_id  (account_id,droplet_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require 'rails_helper'

RSpec.describe DigitalOceanDroplet, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
