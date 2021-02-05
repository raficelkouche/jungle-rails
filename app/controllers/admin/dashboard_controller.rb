class Admin::DashboardController < ApplicationController
  before_filter :authorize
  def show
    @product_count = Product.count
    @categories_count = Category.count
  end
end
