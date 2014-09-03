class ReviewsController < ApplicationController
  REVIEW_ATTR = [:comment, :product_id]
  before_filter -> { load_product(:product_id) }  #load_product in application_controller
  before_filter :load_review, only: [:edit, :update, :destroy]
  before_filter :ensure_logged_in, only: [:create, :update, :destroy]

  def edit
  end

  def create
    @review = @product.reviews.build(secure_params(:review, REVIEW_ATTR))
    @review.user = current_user
    if @review.save
      redirect_to current_product, notice: 'Review created successfully'
    else
      flash.now['alert'] = 'Failure when creating review'
      render 'products/show'
    end
  end

  def update 
    if @review.update_attributes(secure_params(:review, REVIEW_ATTR))
      redirect_to current_product, notice: 'Review updated successfully'
    else
      flash.now['alert'] = 'Failure when updating review'
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to current_product, notice: "Review deleted"
  end

  private
  def load_review
    @review = Review.find(params[:id])
  end

  def current_product
    product_path(@review.product_id)  #chose to grab id from active record in case route no longer nested
  end
end
