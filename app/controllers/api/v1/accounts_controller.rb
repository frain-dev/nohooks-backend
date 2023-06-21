class Api::V1::AccountsController < ApplicationController
  before_action :set_account, only: %i[update destroy]
  before_action :set_account_type, only: %i[create update]

  def index
    accounts = current_user.accounts.order('created_at DESC')
    json = generate_json(status: true,
                         message: ApiResponse::Account.retrieved_successfully,
                         data: accounts)
    render status: 200, json: json
  end

  def show
    json = generate_json(status: true,
                         message: ApiResponse::Account.retrieved_successfully,
                         data: @account)
    render status: 200, json: json
  end

  def create
    type = create_params[:type]

    if type == "render"
      ActiveRecord::Base.transaction do 
        render_account_config = RenderAccountConfiguration.create!(
          api_key: create_params[:data][:api_key]
        )

        @account = Account.create(
          user: current_user,
          name: create_params[:name],
          last_poll_time: DateTime.now,
          configurable: render_account_config
        )

        portal_link = Convoy::PortalLink.new(
          data: {
            name: "#{@account.name}'s dashboard",
            owner_id: @account.id,
            can_manage_endpoint: true
          }
        )

        res = portal_link.save
        raise StandardError, "couldn't create portal link" if res&.response.nil? || res&.response['status'] == false

        @account.update!(portal_link_url: res.response['data']['url'])
      end

      json = generate_json(status: true,
                           message: "Account created successfully",
                           data: @account)
      render status: 201, json: json 
      return
    end
  end

  def update
    ActiveRecord::Base.transaction do
      @account.update!(name: update_params[:name])
      if !update_params[:data].nil?
        @account.configurable.update!(update_params[:data])
      end
    end

    @account.touch
    
    json = generate_json(status: true, 
                         message: "Account updated successfully",
                         data: @account)
    render status: 201, json: json
    return
  end

  def destroy
    @account.destroy
    json = generate_json(status: true, message: "Account deleted successfully")
    render status: 200, json: json
  end
  
  private

  def set_account
    @account ||= Account.where(user: current_user, id: params[:id]).first
  end


  def set_account_type
    @account_type ||= create_params[:type]

    if @account_type.nil?
      if @account&.configurable_type == "RenderAccountConfiguration"
        return "render"
      end
    end
  end

  def create_params
    params.permit(:type, :name, data: {})
  end

  def update_params
    params.permit(:name, data: {})
  end
end
