# == Schema Information
#
# Table name: render_services
#
#  id          :uuid             not null, primary key
#  object_hash :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :uuid
#  service_id  :string           not null
#
# Indexes
#
#  index_render_services_on_account_id  (account_id)
#  index_render_services_on_service_id  (service_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
FactoryBot.define do
  factory :render_service do
    
  end
end
