class Event < ActiveRecord::Base
  #default_scope :order => 'create_at DESC'
  belongs_to :user
  belongs_to :catetory
  #validates_presence_of :content
  #validates_length_of :content, :maximum => 140
  
  named_scope :with_in, lambda { |period|
   period.present? ? { :conditions => [:start_time => TimeRanges[period]] } : {}
  }
  
  named_scope :published, :conditions => {:status => 'published'}
  named_scope :with_category, lambda  { |category_id|
    category_id.present? ? {:conditions => ['category_id = ?', category_id]} : {}
  }



end
