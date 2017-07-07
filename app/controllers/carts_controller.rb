class CartsController < ApplicationController

  def index
    @cart = current_cart
  end

  def show
    @cart = current_cart
  end

  def cart_clean
    @cart = current_cart
    @cart.cart_items.destroy_all
    @cart.save
    redirect_to carts_path
    flash[:warning] = "您已经清空购物车"
  end

  def order_confirm
    @order = Order.new
    @cart = current_cart
  end

end
