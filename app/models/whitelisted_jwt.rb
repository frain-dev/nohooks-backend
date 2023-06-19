# == Schema Information
#
# Table name: whitelisted_jwts
#
#  id         :uuid             not null, primary key
#  aud        :string
#  exp        :datetime         not null
#  jti        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid
#
# Indexes
#
#  index_whitelisted_jwts_on_jti      (jti) UNIQUE
#  index_whitelisted_jwts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class WhitelistedJwt < ApplicationRecord
  belongs_to :user
end
