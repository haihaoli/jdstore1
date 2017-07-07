class OrdersController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = Order.find_by(token: params[:id])
    @productlists = @order.productlists
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @cart = current_cart
    @order.total = @cart.total_price
    if @order.save
      @cart.cart_items.each do |cart_item|
        @productlist = Productlist.new
        @productlist.order = @order
        @productlist.product_name = cart_item.product.title
        @productlist.product_price = cart_item.product.price
        @productlist.quantity = cart_item.quantity
        @productlist.save
      end

      OrderMailer.notify_order_placed(@order).deliver!

      flash[:notice] = "创建订单成功"
      redirect_to order_path(@order.token)
    else
      render "carts/order_confirm"
    end
  end

  def alipay
    @order = Order.find_by(token: params[:id])
    @order.make_payment!
    flash[:notice] = "该笔订单已经成功支付"
    current_cart.cart_items.destroy_all
    redirect_to :back
  end

  def wechan
    @order = Order.find_by(token: params[:id])
    @order.make_payment!
    flash[:notice] = "该笔订单已经成功支付"
    current_cart.cart_items.destroy_all
    redirect_to :back
  end

  def apply_to_cancel
    @order = Order.find_by(token: params[:id])
    OrderMailer.apply_cancel(@order).deliver!
    flash[:notice] = "已提交申请"
    redirect_to :back
  end


  protected

  def order_params
    params.require(:order).permit(:billing_name, :billing_address, :shipping_name, :shipping_address)
  end

end
