# == Schema Information
#
# Table name: notion_databases
#
#  id                              :uuid             not null, primary key
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  database_id                     :string           not null
#  notion_account_configuration_id :uuid
#
# Indexes
#
#  index_notion_databases_on_notion_account_configuration_id  (notion_account_configuration_id)
#  unique_database_per_account                                (notion_account_configuration_id,database_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (notion_account_configuration_id => notion_account_configurations.id)
#
require 'rails_helper'

RSpec.describe NotionDatabase, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
