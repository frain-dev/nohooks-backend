# == Schema Information
#
# Table name: accounts
#
#  id                  :uuid             not null, primary key
#  configurable_type   :string
#  name                :string           not null
#  portal_link_url     :string
#  status              :integer          default("active")
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
  attributes :id, :name, :type, :portal_link_url, :metadata

  def type
    account_type
  end

  def metadata
    case account_type
    when "render"
      {
        "api_key": object.configurable.api_key
      }
    when "notion"
      {
        "databases": object.notion_databases.pluck(:database_id)
      }
    when "digital_ocean"
      {
        "access_token": object.configurable.access_token
      }
    end
  end

  private 

  def account_type
    case object.configurable_type
    when "RenderAccountConfiguration"
      "render"
    when "NotionAccountConfiguration"
      "notion"
    when "DigitalOceanAccountConfiguration"
      "digital_ocean"
    end
  end
end
