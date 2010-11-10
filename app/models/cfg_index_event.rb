class CfgIndexEvent < ActiveRecord::Base
  default_scope :order => 'show_order ASC'
  
  belongs_to :event
  
  named_scope :valid, :conditions => { :is_valid => true }
end
