# == Schema Information
#
# Table name: profiles
#
#  id         :uuid             not null, primary key
#  firstname  :string           not null
#  lastname   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Profile < ApplicationRecord
  belongs_to :user

  def fullname
    "#{self.firstname} #{self.lastname}"
  end
end
