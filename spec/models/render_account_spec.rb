# == Schema Information
#
# Table name: render_accounts
#
#  id             :uuid             not null, primary key
#  api_key        :string           not null
#  last_poll_time :datetime         not null
#  name           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_render_accounts_on_name_and_api_key  (name,api_key) UNIQUE
#
require 'rails_helper'

RSpec.describe RenderAccount, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
