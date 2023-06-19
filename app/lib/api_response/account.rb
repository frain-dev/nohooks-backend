require_relative 'base'

module ApiResponse
  class Account < ApiResponse::Base
    def self.retrieved_successfully
      "Account retrieved successfully"
    end

    def self.created_successfully
      "Account created successfully"
    end
  end
end
