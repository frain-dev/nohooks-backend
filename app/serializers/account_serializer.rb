# == Schema Information
#
# Table name: accounts
#
#  id                  :uuid             not null, primary key
#  configurable_type   :string
#  name                :string           not null
#  portal_link_url     :string
#  status              :integer          default(0)
#  sync_start_datetime :datetime         not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  configurable_id     :uuid
#  user_id             :uuid             not null
#
# Indexes
#
#  index_accounts_on_configurable  (configurable_type,configurable_id)
#  index_accounts_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class AccountSerializer < ApplicationSerializer
  attributes :id, :name, :type, :portal_link_url, :notion_databases

  def type
    return "render" if object.configurable_type == "RenderAccountConfiguration"
    return "notion" if object.configurable_type == "NotionAccountConfiguration"
  end

  def notion_databases
    object.notion_databases.pluck(:database_id)
  end
end
