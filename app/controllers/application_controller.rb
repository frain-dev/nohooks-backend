class ApplicationController < ActionController::API
  include Response

  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ::ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ::ActiveRecord::RecordNotUnique, with: :record_not_unique

  before_action :authorize_request

  attr_reader :current_user

  protected

  def record_invalid(e)
    json = { status: false, message: e.message, data: e.record.errors }
    render status: 400, json: json
  end

  def record_not_found(e)
    json = generate_json(status: false, message: e.message)
    render status: 400, json: json
  end

  def record_not_unique(e)
    json = generate_json( status: false, message: 'Record exists already')
    render status: 400, json: json
  end

  private

  def authorize_request
    @current_user = Auth::AuthorizeApiRequest.new(request.headers).call[:user]
  rescue StandardError => e
    render status: 400, json: { status: false, message: e.message }
  end
end
