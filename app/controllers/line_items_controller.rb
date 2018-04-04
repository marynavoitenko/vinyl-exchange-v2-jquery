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

  def update
    @lineitem = LineItem.find(params[:id])
    qty_update = params[:line_item][:quantity].to_i - @lineitem.quantity

    if @lineitem.vinyl.inventory >= qty_update

      if @lineitem.update(lineitem_params)
        @lineitem.vinyl.update_inventory(qty_update)
        redirect_to cart_path(current_cart), {notice: 'Item quantity was updated!'}
      else
        redirect_to store_path, {alert: 'Item quantity was not updated. Please check inventory.'}
      end
    else
      redirect_to cart_path(current_cart), {alert: 'Item quantity was not updated. Please check inventory.'}
    end
  end

  private

  def lineitem_params
    params.require(:line_item).permit(:quantity)
  end

end
