# == Schema Information
#
# Table name: render_deployments
#
#  id                :uuid             not null, primary key
#  object_hash       :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  deployment_id     :string           not null
#  render_service_id :uuid
#
# Indexes
#
#  index_render_deployments_on_deployment_id      (deployment_id) UNIQUE
#  index_render_deployments_on_render_service_id  (render_service_id)
#
# Foreign Keys
#
#  fk_rails_...  (render_service_id => render_services.id) ON DELETE => cascade
#
class RenderDeployment < ApplicationRecord
  belongs_to :render_service
end
