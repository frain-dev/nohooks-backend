require_relative 'base'

module ApiResponse
  class User < Base
    def self.invalid_access_token
      'Invalid access token'
    end

    def self.registration_successful
      'User sign in success'
    end
  end
end
