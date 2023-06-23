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
require 'rails_helper'

RSpec.describe NotionAccountConfiguration, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
