# frozen_string_literal: true

module Auth
  class AuthenticateUser
    def initialize(email, keep_me_in)
      @email = email
      @keep_me_in = keep_me_in
    end
  
    # Service entry point
    def call
      payload = { user_id: user.id } if user
      time = @keep_me_in ? ENV['JWT_LONG_EXPIRY_TIME'].to_i.days.from_now(Time.now) : nil
      args = [payload, time].compact
      token = JsonWebToken.encode(*args)
  
      create_whitelist_jwt(payload)
      token
    end
  
    private
  
    attr_reader :email
  
    # verify user credentials
    def user
      user = User.find_by(email: email.downcase)

      if user.nil?
        # raise Authentication error if credentials are invalid
        raise ExceptionHandler::AuthenticationError, 
              ApiResponse::Auth.invalid_credentials
      end

      user
    end
  
    def create_whitelist_jwt(payload)
      user = User.find(payload[:user_id])
  
      WhitelistedJwt.create!(
        jti: payload[:jti],
        aud: payload[:aud],
        exp: Time.at(payload[:exp]),
        user: user
      )
    end
  end
end
