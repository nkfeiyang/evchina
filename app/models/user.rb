class User < ActiveRecord::Base
  acts_as_authentic do |c| 
  #  c.validate_email_field = false
  end
  
  has_many :events, :dependent => :destroy
  has_many :host_infos, :dependent => :destroy
  
end
