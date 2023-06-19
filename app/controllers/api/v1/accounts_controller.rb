class Api::V1::AccountsController < ApplicationController
  def index
    json = generate_json(status: true,
                         message: ApiResponse::Account.retrieved_successfully,
                         data: accounts)
    render status: 200, json: json
  end

  def create
    # TBD
  end

  def destroy
    # TBD
  end
end
