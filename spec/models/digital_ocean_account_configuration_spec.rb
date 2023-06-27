# == Schema Information
#
# Table name: digital_ocean_account_configurations
#
#  id           :uuid             not null, primary key
#  access_token :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe DigitalOceanAccountConfiguration, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
