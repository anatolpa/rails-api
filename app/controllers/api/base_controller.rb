class Api::BaseController < ::ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :authorize_user

  rescue_from UnauthorizedError do |e|
    render_error({ 'message': 'Not Authorized' }, 401)
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render_error({ 'message': 'Not found' }, 404)
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render_error(e.record.errors, 422)
  end

  def render_response(data, status = 200)
    render_json data, status
  end

  def render_error(data, status = 400)
    render_json data, status
  end

  private

  def authorize_user
    @current_session = authenticate_with_http_token do |token, options|
      Session.authorize_user_with_token token
    end

    raise UnauthorizedError.new unless @current_session
  end

  def current_user
    @current_session.try(:user)
  end

  def render_json(data, status)
    render json: data, status: status
  end
end
