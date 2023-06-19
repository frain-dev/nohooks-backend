# frozen_string_literal: true

require_relative 'base'

module ApiResponse
  class Auth < ApiResponse::Base
    def self.login_successful
      'Login successful'
    end

    def self.logout_successful
      'Logout successful'
    end

    def self.missing_token
      'Missing token'
    end

    def self.invalid_token
      'Invalid token'
    end

    def self.invalid_credentials
      'Invalid credentials'
    end

    def self.set_password
      'Please go and set your password'
    end
  end
end
