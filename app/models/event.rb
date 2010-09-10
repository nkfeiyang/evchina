class Event < ActiveRecord::Base
  #default_scope :order => 'create_at DESC'
  belongs_to :user
  belongs_to :catetory
  #validates_presence_of :content
  #validates_length_of :content, :maximum => 140
  
  named_scope :in, lambda { |period|
   { :conditions => [:start_time => TimeRanges[period]] }
  }
  
  named_scope :published, :conditions => {:status => 'published'}
  named_scope :category, lambda  { |category_id|
    {:conditions => [':category_id = ?', category_id]}
  }



end
