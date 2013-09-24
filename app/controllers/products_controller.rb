class ProductsController < ApplicationController
  before_filter :authorize
  respond_to :html, :png, :pdf

  def show
    photo = current_user.photos.find!(params[:photo_id])
    product = Product.find!(params[:id])

    @line_item = LineItem.new(photo_id: photo.id, product_id: product.id)

    respond_with(@line_item)
  end
end
