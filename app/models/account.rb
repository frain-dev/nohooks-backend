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
#
# Indexes
#
#  index_accounts_on_configurable  (configurable_type,configurable_id)
#
class Account < ApplicationRecord
  belongs_to :configurable, polymorphic: true
end
