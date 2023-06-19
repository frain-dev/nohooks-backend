class AuthenticationController < ApplicationController
  include HTTParty

  skip_before_action :authorize_request, only: :google_oauth

  def google_oauth
    google_user = get_google_user_data(google_params[:access_token])

    if google_user.code != 200 
      json = generate_json(status: false,
                           message: ApiResponse::User.invalid_access_token)
      render status: 400, json: json
      return
    end

    user = User.create_user_for_google(google_user)

    # Generate Access Token & respond.
    token = Auth::AuthenticateUser.new(user.email, true).call
    data = Models::RegistrationResponse.new(user: user, 
                                            profile: user.profile,
                                            token: token)

    json = generate_json(status: true,
                         message: ApiResponse::User.registration_successful,
                         data: data)

    render status: 200, json: json
  end

  private


  def get_google_user_data(access_token)
    url = "#{ENV['GOOGLE_API']}#{access_token}"
    HTTParty.get(url)
  end

  def google_params
    params.permit(:access_token)
  end
end
