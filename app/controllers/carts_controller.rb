class CartsController < ApplicationController
  before_filter :authorize

  def show 
    @cart = current_user.cart || Cart.create(user_id: current_user.id)
  end
end
