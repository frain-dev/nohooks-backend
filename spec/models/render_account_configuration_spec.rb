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
require 'rails_helper'

RSpec.describe RenderAccountConfiguration, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
