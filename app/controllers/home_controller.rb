class HomeController < ApplicationController
  def index
    @products = Product.all
    @products = @products.search(@search) if @search.present?

    @products = @products.page(params[:page]).order(updated_at: :desc).per(10)

    respond_to do |format|
      format.html
      format.csv { send_data generate_csv(Product.all), file_name: 'products.csv' }
    end
  end
end
