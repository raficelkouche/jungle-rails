require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do
    before :each do 
      
    end
    it "creates a user if all the fields are provided" do
      @user = User.new(name:"Sara", email:"sara@hotmail.com", password:"abcdefg", password_confirmation:"abcdefg")
      @user.save
      expect(@user.id).to be_present
    end
    it "fails if name is missing" do
      @user = User.new(name:"", email:"sara@hotmail.com", password:"abcdefg", password_confirmation:"abcdefg")
      @user.save
      expect(@user.errors.full_messages[0]).to match(/name can't be blank/i)
    end
    it "fails if password is less than 6 characters" do
      @user = User.new(name:"Sara", email:"sara@hotmail.com", password:"abcde", password_confirmation:"abcde")
      @user.save
      expect(@user.errors.full_messages[0]).to match(/password is too short/i)
    end
    it "fails if password and password confirmation do not match" do
      @user = User.new(name:"Sara", email:"sara@hotmail.com", password:"abcdefg", password_confirmation:"hijklmno")
      @user.save
      expect(@user.errors.full_messages[0]).to match(/password confirmation doesn't match password/i)
    end
    it "fails if password field is missing" do
      @user = User.new(name:"Sara", email:"sara@hotmail.com", password:"", password_confirmation:"")
      @user.save
      expect(@user.errors.full_messages[0]).to match(/password can't be blank/i)
    end
    it "fails if email address exists in the database" do
      User.create(name:"Jack", email:"sara@hotmail.com", password:"1234567", password_confirmation:"1234567")
      @user = User.new(name:"Sara", email:"sara@hotmail.com", password:"abcdefg", password_confirmation:"abcdefg")
      @user.save
      expect(@user.errors.full_messages[0]).to match(/email has already been taken/i)
    end
  end

  describe '.authenticate_with_credentials' do
    before :each do
      @user = User.create(name:"John", email:"john@hotmail.com", password:"123456", password_confirmation:"123456")
    end
    it "should pass if the email and password are correct" do
      expect(User.authenticate_with_credentials("john@hotmail.com", "123456")).to be_truthy
    end
    it "should fail if the email and password are incorrect" do
      expect(User.authenticate_with_credentials("john@hotmail.com", "1234")).to be_nil
    end
    it "should pass if the email contains trailing spaces" do
      expect(User.authenticate_with_credentials("  john@hotmail.com  ", "123456")).to be_truthy
    end
    it "should pass if the email contains upper case letters" do
      expect(User.authenticate_with_credentials("  joHn@hotmail.com  ", "123456")).to be_truthy
    end
  end
end
