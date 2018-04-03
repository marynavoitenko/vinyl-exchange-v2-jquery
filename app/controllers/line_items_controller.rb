class LineItemsController < ApplicationController
  def create
    if current_cart.add_item(params[:vinyl_id])
      if current_cart.save
        redirect_to cart_path(current_cart), {notice: 'Item added to cart!'}
      end
    else
      redirect_to store_path, {alert: 'Item was not added. Please check inventory.'}
    end
  end
end
