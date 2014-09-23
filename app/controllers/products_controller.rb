class ProductsController < ApplicationController
  PRODUCT_ATTR = [:name, :description, :price_in_cents]
  before_filter -> { load_product(:id) }, only: [:show, :edit, :update, :destroy]    #from application_controller  

  def index
    @products = if params[:search]
      Product.where("LOWER(name) LIKE LOWER(?)", "%#{params[:search]}%")
    else
      Product.all
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @ajax = true;   #ajaxified creation
    if current_user
      @review = @product.reviews.build
    end
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(secure_params(:product, PRODUCT_ATTR))
    if @product.save
      redirect_to products_path, notice: "Product created successfully"
    else
      flash.now['alert'] = 'Failure when creating product'
      render :new
    end
  end

  def update
    if @product.update_attributes(secure_params(:product, PRODUCT_ATTR))
      redirect_to product_path, notice: "Product updated successfully"
    else
      flash.now['alert'] = 'Failure when updating product'
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "Product deleted"
  end
end