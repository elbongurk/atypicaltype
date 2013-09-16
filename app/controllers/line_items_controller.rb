class LineItemsController < ApplicationController
  before_filter :authorize

  def create
    line_item = current_user.cart.line_items.where(create_params).first_or_initialize

    line_item.quantity += 1 if line_item.persisted?

    line_item.save

    redirect_to cart_url
  end

  private

  def create_params
    params.require(:line_item).permit(:product_id, :photo_id, :contrast, :brightness)
  end
end
