class LineItemsController < ApplicationController
  before_filter :authorize

  def create
    line_item = current_user.cart.line_items.new
    
    line_item.variant = Variant.where(sku: params[:line_item][:variant_id]).first
    line_item.photo = Photo.find(params[:line_item][:photo_id])
    
    line_item.save

    redirect_to cart_url
  end

  def destroy
    line_item = current_user.cart.line_items.find(params[:id])
    
    line_item.destroy

    redirect_to cart_url
  end

  def update
    line_item = current_user.cart.line_items.find(params[:id])

    line_item.update(update_params)

    redirect_to cart_url
  end

  private

  def update_params
    params.require(:line_item).permit(:quantity)
  end

  def create_params
    params.require(:line_item).permit(:photo_id)
  end
end
