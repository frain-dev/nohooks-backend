# == Schema Information
#
# Table name: notion_databases
#
#  id          :uuid             not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :uuid
#  database_id :string           not null
#
# Indexes
#
#  index_notion_databases_on_account_id  (account_id)
#  unique_database_per_account           (account_id,database_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class NotionDatabase < ApplicationRecord
  belongs_to :account
  has_many :notion_rows, dependent: :delete_all
end
