# == Schema Information
#
# Table name: render_account_configurations
#
#  id         :uuid             not null, primary key
#  api_key    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class RenderAccountConfiguration < ApplicationRecord
  has_one :account, as: :configurable
end
