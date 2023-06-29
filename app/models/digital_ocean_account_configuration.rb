# == Schema Information
#
# Table name: digital_ocean_account_configurations
#
#  id           :uuid             not null, primary key
#  access_token :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class DigitalOceanAccountConfiguration < ApplicationRecord
  validates_with PlatformConfigurationValidator

  has_one :account, as: :configurable, class_name: 'Account'
end
