class CartsController < ApplicationController

  def show
    @cart = current_cart
  end

  def edit
    @cart = Cart.find(params[:id])
  end

end
