class ProductsController < ApplicationController
  before_action :get_product, only: [:update, :show, :edit, :destroy]
  def index
    @products = Product.where(published: nil)
  end

  def show
    #@product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @categories = Category.all
  end
  
  def create
    @product = Product.new(product_params)
    @categories = Category.all
    # if @product.save
    #   # redirect_to products_url
    #   flash[:notice] = 'successfully'
    #   redirect_to products_url

    # else 
    #   flash.now[:notice] = 'Error'
    #   render :new 
    # end
    return redirect_to products_url, notice: 'you have successfully create product' if @product.save
    flash.now[:notice] = 'There is an error in your form'
    render :new
  end

  def edit
    # @product = Product.find(params[:id])
    render :new
  end

  def update
    #@product = Product.find(params[:id])
    return redirect_to products_url, notice: 'you have successfully update product' if @product.update(product_params)
    flash.now[:notice] = 'There is an error in your update form'
    render :new
  end

  def destroy
    return redirect_to products_url, notice: 'you have successfully delete product' if @product.destroy
    flash.now[:notice] = 'There is an error in your delete form'
    render :new
  end 

  private

  def product_params
    product_params = params.require(:product).permit( :title, :description, :price, :published, :category_id, :country)
  end

  def get_product
    @product = Product.find(params[:id])
  end
end