class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :events, :dependent => :destroy
  has_many :host_infos, :dependent => :destroy
  
end
