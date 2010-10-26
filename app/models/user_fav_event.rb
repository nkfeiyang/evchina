class UserFavEvent < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  
  validates_presence_of :user_id, :event_id
  validates_uniqueness_of :event_id, :scope => :user_id
  
  def has_add_env_fav?(userid, eventid)
    if UserFavEvent.find_by_user_id_and_event_id(userid, eventid).nil?
      false
    else
      true
    end
  end
end
