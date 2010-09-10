class Category < ActiveRecord::Base
  validates_presence_of         :name
  validates_uniqueness_of       :name, :show_order
  validates_numericality_of     :show_order
  
  has_many :events, :dependent => :destroy
  
  default_scope :order => 'show_order ASC'
  named_scope :showorder, lambda  { |category_id|
    {:conditions => [':show_order = ?', category_id]}
  }
  
end
