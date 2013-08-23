class CartsController < ApplicationController
  before_filter :authorize

  def show 
    @cart = current_user.cart
  end
end
