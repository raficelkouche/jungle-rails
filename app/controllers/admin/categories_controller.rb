class Admin::CategoriesController < ApplicationController
  before_filter :authorize
  def index
    @categories = Category.all
    puts @categories.inspect
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))
 
    if @category.save
      redirect_to admin_categories_path
    else
      render 'new'
    end
  end
end
