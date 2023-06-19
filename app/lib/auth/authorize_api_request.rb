module Auth
  class AuthorizeApiRequest
    include Helper
  
    def initialize(headers = {})
      @headers = headers
    end
  
    # Service entry point - return valid user object
    def call
      {
        user: user
      }
    end
  
    private
  
    attr_reader :headers
  
    def user
      # check if user is in the database
      # memoize user object
      @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
     
      WhitelistedJwt.find_by!(jti: decoded_auth_token[:jti])
  
      return @user
      # handle user not found
    rescue ActiveRecord::RecordNotFound => e
      # raise custom error
      raise ExceptionHandler::InvalidToken, "#{ApiResponse::Auth.invalid_token}"
    end
  end
end
