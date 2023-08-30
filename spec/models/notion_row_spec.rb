# == Schema Information
#
# Table name: notion_rows
#
#  id                 :uuid             not null, primary key
#  object_hash        :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  notion_database_id :uuid
#  row_id             :string
#
# Indexes
#
#  index_notion_rows_on_notion_database_id             (notion_database_id)
#  index_notion_rows_on_notion_database_id_and_row_id  (notion_database_id,row_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (notion_database_id => notion_databases.id) ON DELETE => cascade
#
require 'rails_helper'

RSpec.describe NotionRow, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
