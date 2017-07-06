class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  layout "admin"

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "Product created"
      redirect_to admin_products_path
    else
      render "new"
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "Update success"
      redirect_to admin_products_path
    else
      render "edit"
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path
  end

  protected

  def product_params
    params.require(:product).permit(:title, :description, :price, :quantity, :image)
  end

  def require_admin
    if !current_user.admin?
      redirect_to root_path
      flash[:alert] = "You are not admin"
    end
  end

end
