class LineItemsController < ApplicationController
  before_filter :authorize, except: :show
  respond_to :png, :pdf, only: [:show, :preview]

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

  def preview
    @line_item = LineItem.new(preview_params)

    if current_user.photos.exists?(@line_item.photo_id)
      respond_with(@line_item)
    else
      deny_access
    end
  end

  def update
    @line_item = LineItem.find(params[:id])

    @line_item.update(update_params)

    redirect_to cart_url
  end

  def show
    @line_item = LineItem.find(params[:id])
    respond_with(@line_item)
  end
  
  private

  def update_params
    params.require(:line_item).permit(:quantity)
  end

  def create_params
    params.require(:line_item).permit(:product_id, :photo_id, :contrast, :brightness)
  end

  def preview_params
    params.permit(:product_id, :photo_id, :contrast, :brightness)
  end
end
