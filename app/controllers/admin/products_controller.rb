class Admin::ProductsController < ApplicationController
  before_action :authenticate_admin!, except: %i[index show]

  def index
    @products = Product.all
    @products = @products.search(@search) if @search.present?

    @products = @products.page(params[:page]).order(updated_at: :desc).per(10)

    respond_to do |format|
      format.html
      format.csv { send_data generate_csv(Product.all), file_name: 'products.csv' }
    end
  end

  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.create(product_params)

    flash[:error] = @product.errors.full_messages if @product.invalid?

    redirect_to action: :index
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to action: :index
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to action: :index
  end

  def delete_image_attachment
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
    redirect_to action: :index
  end

  def csv_upload
    data = params[:csv_file].read.split("\n")
    data.each do |line|
      attr = line.split(',').map(&:strip)
      Product.create title: attr[0], description: attr[1], stock: attr[2], price: attr[3]
    end
    redirect_to action: :index
  end

  private

  def generate_csv(articles)
    articles.map { |a| [a.title, a.description, a.stock, a.price, a.created_at.to_date].join(',') }.join("\n")
  end

  def product_params
    params.require(:product).permit(:title, :description, :cover_image, :stock, :price, :status, images: [],
                                                                                                 category_ids: [])
  end
end
