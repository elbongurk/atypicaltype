class LineItemsController < ApplicationController
  before_filter :authorize

  def create
    line_item = current_user.cart.line_items.where(create_params).first_or_initialize

    line_item.quantity += 1 unless line_item.new_record?

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
    params.require(:line_item).permit(:product_id, :photo_id, :contrast, :brightness)
  end
end
