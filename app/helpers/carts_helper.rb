module CartsHelper
  def current_cart
    if cart = current_user.carts.find { |c| c.status != "submitted" }
      @cart = cart
    else
      @cart = current_user.carts.build
    end
  end
end
