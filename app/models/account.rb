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
class Account < ApplicationRecord
  belongs_to :configurable, polymorphic: true, dependent: :destroy
  belongs_to :user

  def render_services
    RenderService.where(account: self)
  end

  def notion_databases
    NotionDatabase.where(account: self)
  end
end
