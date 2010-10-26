class UserFavEvent < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  
  validates_presence_of :user_id, :event_id
  validates_uniqueness_of :event_id, :scope => :user_id
end
