class User < ActiveRecord::Base
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_confirmation_of :password
  validates_confirmation_of :username

  # From ri:
  # attr_reader: Creates instance variables and corresponding methods that return
  # the value of each instance variable
  attr_reader :password
  before_save :downcase_username

  def self.random_password
    Array.new(8){rand(62)}.map{ |i| i_to_c i }.join
  end

  def self.hashed_password(pw, salt)
    Digest::MD5.hexdigest(pw + salt)
  end

  # Case insensitive version
  def self.find_by_username_i(username)
    self.find(:first, :conditions => ['username = ?', username.downcase])
  end

  def downcase_username
    self.username = self.username.downcase
  end

  # Set a password for a user
  def password=(pw)
    @password = pw #used by confirmation validator
    salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp # 2^48 combos
    self.password_salt, self.password_hash =
      salt, User.hashed_password(pw, salt)
  end

  # Checks if a given password is correct.
  def password_is?(pw)
    Digest::MD5.hexdigest(pw + password_salt) == password_hash
  end

  def self.is_admin_password?(pw)
    User.find(:all, :conditions => ['is_admin = ?', true]).inject(false) do |acc, admin_user|
      acc || admin_user.password_is?(pw)
    end
  end

  # Resets the user's password and returns it
  def reset_password
    new_password = User.random_password
    self.password = new_password
    return new_password
  end

  private

  def self.i_to_c(i)
    if i >= 0 && i <= 25
      (i+?A).chr
    elsif i >= 26 && i <= 51
      (i-26+?a).chr
    else
      (i-52+?0).chr
    end
  end

end
