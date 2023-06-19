# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile
  has_many :accounts

  def self.create_user_for_google(data)
    ActiveRecord::Base.transaction do 
      user = where(email: data["email"]).first_or_initialize.tap do |user|
        user.provider="google_oauth2"
        user.email=data["email"]
        user.password=Devise.friendly_token[0,20]
        user.password_confirmation=user.password
        user.save!
      end

      Profile.find_or_create_by(
        user: user,
        firstname: data['given_name'],
        lastname: data['family_name']
      )

      user
    end
  end
end
