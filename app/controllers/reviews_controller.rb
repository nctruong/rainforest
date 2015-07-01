class ReviewsController < ApplicationController
  before_action :get_review, only: [:show, :destroy]
  before_action :load_product
  before_action :ensure_logged_in, only: [:create, :destroy]

  def show
  end

  def create
    @review = @product.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to product_path(@product), notice: "Review created successfully"
    else
      render 'products/show'
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

  def load_product
    @product = Product.find(params[:product_id])
  end
end
