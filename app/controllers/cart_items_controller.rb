class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:id])
    @product = @cart_item.product
    @cart_item.destroy

    flash[:warning] = "你已经成功将 #{@product.title} 移出购物车"
    redirect_to :back
  end

  def update
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:id])
    @product = @cart_item.product
    if @cart_item.update(cart_item_params)
      redirect_to :back
      flash[:notice] = "更改数量成功"
    else
      redirect_to :back
    end
  end

  protected

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end


end
