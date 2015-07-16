class ReviewsController < ApplicationController
  before_action :get_review, only: [:show, :destroy]
  before_action :get_product
  before_action :ensure_logged_in, only: [:create, :destroy]

  def show
  end

  def create
    @review = @product.reviews.build(review_params)
    @review.user = current_user

    respond_to do |format|
      if @review.save
        format.html { redirect_to product_path(@product.id), notice: "Review was added successfully" }
        format.js {} # This will look for app/views/reviews/create.js.erb
      else
        format.html { render 'products/show', alert: "An error occurred"  }
        format.js {} # This will look for app/views/reviews/create.js.erb
      end
    end
  end

  def destroy
    @review.destroy
    redirect_to product_path(@product)
  end

  private
  def review_params
    params.require(:review).permit(:comment, :product_id)
  end

  def get_review
    @review = Review.find(params[:id])
  end

  def get_product
    @product = Product.find(params[:product_id])
  end
end
