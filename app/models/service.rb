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
class Service < ApplicationRecord
end
