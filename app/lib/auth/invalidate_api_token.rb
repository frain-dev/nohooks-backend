module Auth
  class InvalidateApiToken
    include Helper
  
    def initialize(headers)
      @headers = headers
    end
  
    # Service entry point
    def call
      jwt = WhitelistedJwt.find_by!(jti: decoded_auth_token[:jti]) if decoded_auth_token
      jwt.destroy!
    end
  
    private
    attr_reader :headers
  end
end
