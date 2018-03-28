class LineItemsController < ApplicationController
  def create
    current_cart.add_item(params[:vinyl_id])
    if current_cart.save
      redirect_to cart_path(current_cart), {notice: 'Item added to cart!'}
    else
      redirect_to store_path, {notice: 'o_O unable to add item '}
    end
  end
end
