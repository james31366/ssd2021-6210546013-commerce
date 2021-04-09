# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate_admin!, except: %i[index show]

  def index
    @categories = Product.all
    if @search.present?
      @categories = @categories.where('title LIKE ? or body LIKE ?', "%#{@search}", "%#{@search}").page(@search).per(5)
    end
    @categories = @categories.page(params[:page]).per(5)
  end

  def new
    @category = Product.new
  end

  def show
    @category = Product.find(params[:id])
  end

  def create
    @category = Product.create(product_params)

    flash[:error] = @category.errors.full_messages if @category.invalid?

    redirect_to action: :index
  end

  def edit
    @category = Product.find(params[:id])
  end

  def update
    @category = Product.find(params[:id])
    @category.update(product_params)
    redirect_to action: :index
  end

  def destroy
    @category = Product.find(params[:id])
    @category.destroy
    redirect_to action: :index
  end

  def csv_upload
    data = params(:csv_file).read.split("\n")
    data.each do |line|
      attr = line.split(',').map(&:strip)
      Product.create title: attr[0], description: attr[1], stock: attr[2]
    end
    redirect_to action: :index
  end

  private

  def product_params
    params.require(:category).permit(:title, :description, :stock)
  end
end
