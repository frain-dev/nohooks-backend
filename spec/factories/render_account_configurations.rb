# == Schema Information
#
# Table name: render_account_configurations
#
#  id         :uuid             not null, primary key
#  api_key    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_render_account_configurations_on_api_key  (api_key) UNIQUE
#
FactoryBot.define do
  factory :render_account_configuration do
    
  end
end
