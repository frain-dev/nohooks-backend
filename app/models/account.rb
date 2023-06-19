# == Schema Information
#
# Table name: accounts
#
#  id                :uuid             not null, primary key
#  configurable_type :string
#  last_poll_time    :datetime         not null
#  name              :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  configurable_id   :uuid
#  user_id           :uuid             not null
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
end
