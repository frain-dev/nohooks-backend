module Auth
  module Helper

    private 

    # decode authentication token
    def decoded_auth_token
      @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    end

    # check for token in `Authorization` header
    def http_auth_header
      if headers['Authorization'].present?
        return headers['Authorization'].split(' ').last
      end
      
      raise ExceptionHandler::MissingToken, ApiResponse::Auth.missing_token
    end
  end
end
