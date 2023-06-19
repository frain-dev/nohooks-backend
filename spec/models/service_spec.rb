# == Schema Information
#
# Table name: services
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_services_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Service, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
