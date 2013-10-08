class VariantsController < ApplicationController
  respond_to :png, :pdf

  def show
    @line_item = LineItem.new
    @line_item.photo = Photo.find(params[:photo_id])
    @line_item.variant = Variant.where(sku: params[:id]).first

    respond_with(@line_item)
  end
end
