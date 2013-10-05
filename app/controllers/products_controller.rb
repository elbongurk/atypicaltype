class ProductsController < ApplicationController
  respond_to :png, :pdf

  def show
    @line_item = LineItem.new(photo_id: params[:photo_id], product_id: params[:id])

    respond_with(@line_item)
  end
end
