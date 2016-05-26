class Api::ImagesController < Api::BaseController

  def index
    @images = current_user.images.page(page).per(limit)
    render_response @images
  end

  def show
    @image = current_user.images.find(params[:id])
    render_response @image
  end

  def create
    @image = current_user.images.create!(image_params)
    render_response @image, 201
  end

  def destroy
    image = current_user.images.find(params[:id])
    image.destroy
    render_response nil, 204
  end

  private

  def image_params
    params.permit(:attachment)
  end

  def page
    params[:page] || 1
  end

  def limit
    params[:limit] || 20
  end
end
