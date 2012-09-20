class ProductsController < ApplicationController
  before_filter :admin_user, only: [:destroy, :update]
  
  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def index
    @products = Product.paginate(page: params[:page])
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:success] = "Product successfully added!"
      redirect_to @product
    else
      render 'new'
    end
  end
  
  def edit
  end

  def update
    if @product.update_attributes(params[:product])
      flash[:success] = "Product updated"
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    debugger
    product_to_destroy = Product.find(params[:id])
    product_to_destroy.destroy
    flash[:success] = "Product destroyed."
    redirect_to products_url
  end

  private
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
