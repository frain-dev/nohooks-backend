class Api::V1::AccountsController < ApplicationController
  before_action :set_account, only: %i[show update destroy]
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
      create_render_account_configuration
    elsif type == "notion"
      create_notion_account_configuration
    elsif type == "digital_ocean"
      create_digital_ocean_configuration
    else
      json = generate_json(status: true, message: ApiResponse::Account.creation_failed)
      render status: 400, json: json
    end

    json = generate_json(status: true,
                         message: ApiResponse::Account.created_successfully,
                         data: @account)
    render status: 201, json: json 

  rescue OAuth2::Error => e
    json = generate_json(status: false, message: e.description)
    render status: 400, json: json
  end

  def update
    if @account.configurable_type == "RenderAccountConfiguration"
      update_render_configuration
    elsif @account.configurable_type == "NotionAccountConfiguration"
      update_notion_configuration
    elsif @account.configurable_type == "DigitalOceanAccountConfiguration"
      update_digital_ocean_configuration
    else
      json = generate_json(status: false, message: ApiResponse::Account.update_failed)
      render status: 400, json: json
    end


    @account.touch
    
    json = generate_json(status: true, 
                         message: "Account updated successfully",
                         data: @account)
    render status: 201, json: json
  end

  def destroy
    @account.destroy
    json = generate_json(status: true, message: "Account deleted successfully")
    render status: 200, json: json
  end
  
  private

  def create_render_account_configuration
    ActiveRecord::Base.transaction do 
      render_account_config = RenderAccountConfiguration.create!(
        api_key: create_params[:data][:api_key]
      )

      @account = Account.create!(
        user: current_user,
        name: create_params[:name],
        sync_start_datetime: Time.now.utc.iso8601(3),
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
      raise StandardError, "couldn't create portal link" if res&.response.nil? || 
        res&.response['status'] == false

      @account.update!(portal_link_url: res.response['data']['url'])
    end
  end 

  def create_digital_ocean_configuration
    ActiveRecord::Base.transaction do
      digital_ocean_config = DigitalOceanAccountConfiguration.create!(
        access_token: create_params[:data][:access_token]
      )

      @account = Account.create!(
        user: current_user, 
        name: create_params[:name],
        sync_start_datetime: Time.now.utc.iso8601(3),
        configurable: digital_ocean_config
      )

      portal_link = Convoy::PortalLink.new(
        data: {
          name: "#{@account.name}'s dashboard",
          owner_id: @account.id,
          can_manage_endpoint: true
        }
      )

      res = portal_link.save
      raise StandardError, "couldn't create portal link" if res&.response.nil? ||
        res&.response['status'] == false

      @account.update!(portal_link_url: res.response['data']['url'])
    end
  end

  def create_notion_account_configuration
    client = OAuth2::Client.new(ENV['NOTION_OAUTH_CLIENT_ID'],
                               ENV['NOTION_OAUTH_CLIENT_SECRET'],
                               site: ENV['NOTION_SITE_URL'],
                               token_url: ENV['NOTION_TOKEN_URL'])

    params = {redirect_uri: ENV['NOTION_REDIRECT_URI']}
    params = params.merge(auth_header)
    access_token = client.auth_code.get_token(create_params[:data][:code], params)

    ActiveRecord::Base.transaction do 
      notion_account_config = NotionAccountConfiguration.create!(
        access_token: access_token.token
      )

      @account = Account.create!(
        user: current_user,
        name: create_params[:name],
        sync_start_datetime: Time.now.utc.iso8601(3),
        configurable: notion_account_config
      )

      portal_link = Convoy::PortalLink.new(
        data: {
          name: "#{}'s dashboard",
          owner_id: @account.id,
          can_manage_endpoint: true
        }
      )

      databases = create_params[:data][:database].each do |db_id|
        NotionDatabase.create!(account: @account, database_id: db_id)
      end

      res = portal_link.save
      raise StandardError, "couldn't create portal link" if res&.response.nil? || 
        res&.response['status'] == false

      @account.update!(portal_link_url: res.response['data']['url'])
    end
  end

  def update_render_configuration
    ActiveRecord::Base.transaction do
      @account.update!(name: update_params[:name])
      if !update_params[:data].nil?
        @account.configurable.update!(update_params[:data])
      end
    end
  end

  def update_digital_ocean_configuration
    ActiveRecord::Base.transaction do
      @account.update!(name: update_params[:name])
      if !update_params[:data].nil?
        @account.configurable.update!(update_params[:data])
      end
    end
  end

  def update_notion_configuration
    ActiveRecord::Base.transaction do
      @account.update!(name: update_params[:name])
      if !update_params[:data].nil?
        NotionDatabase.where(account: @account).destroy_all
        update_params[:data][:database].each do |db_id|
          NotionDatabase.create!(account: @account, database_id: db_id)
        end
      end
    end
  end

  def set_account
    @account ||= Account.find_by!(user: current_user, id: params[:id])
  end

  def set_account_type
    @account_type ||= create_params[:type]

    if @account_type.nil?
      if @account&.configurable_type == "RenderAccountConfiguration"
        return "render"
      elsif @account&.configurable_type == "NotionAccountConfiguration"
        return "notion"
      elsif @account&.configurable_type == "DigitalOceanAccountConfiguration"
        return "digital_ocean"
      end
    end
  end

  def create_params
    params.permit(:type, :name, data: {})
  end

  def update_params
    params.permit(:name, data: {})
  end

  def auth_header
    authenticator = OAuth2::Authenticator.new(
      ENV['NOTION_OAUTH_CLIENT_ID'],
      ENV['NOTION_OAUTH_CLIENT_SECRET'],
      :basic_auth)

    authenticator.apply({})
  end
end
