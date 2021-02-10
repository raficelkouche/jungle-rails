class User < ActiveRecord::Base
  has_secure_password

  validates :password, :password_confirmation, presence: true
  validate :passwords_should_match
  validates :password, :password_confirmation, length: {minimum: 6}
  validates :email, :name, presence: true
  validates :email, uniqueness: {case_sensitive: false}

  def self.authenticate_with_credentials (email, password)
    @user = User.find_by_email(email.strip.downcase)
    
    if @user && @user.authenticate(password)
      return @user
    else
      return nil
    end
  end
  
  private
  def passwords_should_match 
    if (password != password_confirmation)
      errors.add(:passwords, "should match!")
    end
  end
end
