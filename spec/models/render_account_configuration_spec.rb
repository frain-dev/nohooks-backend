# == Schema Information
#
# Table name: render_account_configurations
#
#  id         :uuid             not null, primary key
#  api_key    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe RenderAccountConfiguration, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
