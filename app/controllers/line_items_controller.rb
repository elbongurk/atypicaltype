class LineItemsController < ApplicationController
  before_filter :authorize

  def show
    @line_item = current_user.cart.line_items.find(params[:id])
  end

  def create
    line_item = current_user.cart.line_items.new

    line_item.photo = Photo.find(params[:line_item][:photo_id])
    line_item.variant = Variant.from_param(params[:line_item][:variant][:sku])
    
    line_item.save!

    redirect_to cart_url
  end

  def destroy
    line_item = current_user.cart.line_items.find(params[:id])
    
    line_item.destroy!

    redirect_to cart_url
  end

  def update
    line_item = current_user.cart.line_items.find(params[:id])

    if params[:line_item][:quantity].present?
      line_item.quantity = params[:line_item][:quantity]
    end
    
    if params[:line_item][:variant].present?
      line_item.variant = Variant.from_param(params[:line_item][:variant][:sku])
    end
    
    line_item.save!

    redirect_to cart_url
  end
end
