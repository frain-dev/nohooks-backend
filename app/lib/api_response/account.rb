require_relative 'base'

module ApiResponse
  class Account < ApiResponse::Base
    def self.retrieved_successfully
      "Account retrieved successfully"
    end

    def self.created_successfully
      "Account created successfully"
    end

    def self.created_failed
      "Account creation failed"
    end

    def self.update_failed
      "Account update failed"
    end
  end
end
