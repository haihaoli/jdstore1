class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])
    @cart_item = current_cart.cart_items.find_by(product_id: params[:id])


    if @product.quantity > 0
      if @cart_item.present?
        flash[:warning] = "购物车内已经有该商品"
        redirect_to :back
      else
        current_cart.add_product_to_cart(@product)
        flash[:notice] = "成功加入购物车"
        redirect_to :back
      end
    else
      flash[:warning] = "此商品缺少库存"
    end
  end



end
