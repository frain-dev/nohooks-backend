# frozen_string_literal: true

module Models
  class RegistrationResponse < ActiveModelSerializers::Model
    attributes :user, :profile, :token
  end
end
