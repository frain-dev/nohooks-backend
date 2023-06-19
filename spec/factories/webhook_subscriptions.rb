# == Schema Information
#
# Table name: webhook_subscriptions
#
#  id                     :uuid             not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  convoy_endpoint_id     :string           not null
#  convoy_subscription_id :string           not null
#
FactoryBot.define do
  factory :webhook_subscription do
    
  end
end
