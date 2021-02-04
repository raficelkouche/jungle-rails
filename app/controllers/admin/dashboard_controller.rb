class Admin::DashboardController < ApplicationController
  def show
    @product_count = Product.count
    @categories_count = Category.count
  end
end
