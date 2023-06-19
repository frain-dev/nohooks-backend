# == Schema Information
#
# Table name: render_services
#
#  id                :uuid             not null, primary key
#  object_hash       :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  render_account_id :uuid
#  service_id        :string           not null
#
# Indexes
#
#  index_render_services_on_render_account_id  (render_account_id)
#  index_render_services_on_service_id         (service_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (render_account_id => accounts.id)
#
class RenderService < ApplicationRecord
end
