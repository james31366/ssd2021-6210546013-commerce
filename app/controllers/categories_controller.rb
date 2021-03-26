class CategoriesController < ApplicationController
  before_action :authenticate_admin!, except: %i[index show]

  def index
    @categories = Category.all
    if @search.present?
      @categories = @categories.where('title LIKE ? or body LIKE ?', "%#{@search}", "%#{@search}").page(@search).per(5)
    end
    @categories = @categories.page(params[:page]).per(5)
  end

  def new
    @category = Category.new
  end

  def show
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.create(product_params)

    flash[:error] = @category.errors.full_messages if @category.invalid?

    redirect_to action: :index
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update(product_params)
    redirect_to action: :index
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to action: :index
  end

  private

  def product_params
    params.require(:category).permit(:name, :description, :stock)
  end
end
