require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do
    before(:each) do
      @category = Category.create(name: "cookware")
    end
    it "should save the new product if all fields are present" do
      @product = @category.products.new(name: "microwave", price: "2000", quantity:"10")  
      @product.save
      expect(@product.id).to be_present
    end
    it "should fail if product name is missing" do
      @product = @category.products.new(name: "", price: "2000", quantity:"10")  
      @product.save
      expect(@product.errors.full_messages[0]).to match(/name can't be blank/i)
    end
     it "should fail if product price is missing" do
      @product = @category.products.new(name: "microwave",price: "",quantity:"10")  
      @product.save
      expect(@product.errors.full_messages[0]).to match(/price is not a number/i)
    end
     it "should fail if product quantity is missing" do
      @product = @category.products.new(name: "microwave",price: "200",quantity:"")  
      @product.save
      expect(@product.errors.full_messages[0]).to match(/quantity can't be blank/i)
    end
    it "should fail if category is missing" do
      @product = Product.new(name: "microwave",price: "200",quantity:"10")  
      @product.save
      expect(@product.errors.full_messages[0]).to match(/category can't be blank/i)
    end
  end
end
