class LineItemsController < ApplicationController
  before_filter :authorize

  def show
    @line_item = current_user.cart.line_items.find(params[:id])
  end

  def create
    current_user.cart.line_items.create(create_params)

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
    params.require(:line_item).permit(:quantity, :variant_id)
  end

  def create_params
    params.require(:line_item).permit(:photo_id, :variant_id)
  end
end
