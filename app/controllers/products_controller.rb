class ProductsController < ApplicationController
  before_filter :authorize

  def index
    photo = Photo.find(params[:photo_id])
    product = Product.first

    #TODO: This will one day show a page to select a product (Poster, Canvas, Framed Poster, etc)
    
    redirect_to photo_product_url(photo, product)
  end

  def show
    @photo = Photo.find(params[:photo_id])
    @product = Product.find(params[:id])

    @variant = @product.variants.first
  end
end
