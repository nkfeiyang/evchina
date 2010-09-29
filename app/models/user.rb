class User < ActiveRecord::Base
  acts_as_authentic
  #acts_as_authentic do |c| 
    #c.validate_email_field = false
  #end
  
  has_many :events, :dependent => :destroy
  has_many :host_infos, :dependent => :destroy
  
  #attr_accessor :password
  #validates_confirmation_of :password
  
  #validates_presence_of :password
  #validates_length_of   :password, :within => 6..40
  
  #EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  #validates_presence_of     :login,  :email
  #validates_length_of       :login,  :maximum => 50 
  #validates_format_of       :email, :with => EmailRegex
  #validates_uniqueness_of   :email, :case_sensitive => false
  
end
