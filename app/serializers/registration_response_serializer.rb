# frozen_string_literal: true

class RegistrationResponseSerializer < ApplicationSerializer
  attributes :email, :firstname, :lastname, :token

  def email
    object.user.email
  end

  def firstname
    object.profile.firstname
  end

  def lastname
    object.profile.lastname
  end
end
