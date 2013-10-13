class ProductsController < ApplicationController
  before_filter :authorize

  def index
    photo = Photo.find(params[:photo_id])
    product = Product.first

    #TODO: This will one day show a page to select a product (Poster, Canvas, Framed Poster, etc)
    
    redirect_to photo_product_url(photo, product)
  end

  def show
    @line_item = LineItem.new
    
    @line_item.photo = Photo.find(params[:photo_id])
    @line_item.variant = Variant.where(product_id: params[:id]).first
  end
end
