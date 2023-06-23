# == Schema Information
#
# Table name: notion_account_configurations
#
#  id           :uuid             not null, primary key
#  access_token :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_notion_account_configurations_on_access_token  (access_token)
#
class NotionAccountConfiguration < ApplicationRecord
  has_one :account, as: :configurable, class_name: 'Account'
  has_many :notion_databases
end
