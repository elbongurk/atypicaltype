class PhotosController < ApplicationController
  before_filter :authorize

  def index
    @photos = current_user.photos
  end

  def show
    redirect_to canvas_photo_url(params[:id])
  end

  def canvas
    photo = current_user.photos.find(params[:id])
    product = Product.canvases.first

    @line_item = LineItem.new(photo_id: photo.id, product_id: product.id)
  end
end
