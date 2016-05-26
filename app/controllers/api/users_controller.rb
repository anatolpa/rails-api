class Api::UsersController < Api::BaseController
  skip_before_action :verify_authenticity_token, only: :create
  skip_before_action :authorize_user, only: :create
  before_action :find_user, only: [:show, :update, :destroy]

  def index
    render_response User.all
  end

  def show
    render_response @user
  end

  def create
    user = User.create! user_params
    render_response user, 201
  end

  def destroy
    @user.destroy

    render_response nil, 204
  end

  def update
    @user = @user.update! user_params
    render_response @user, 200
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:email, :password)
  end
end
