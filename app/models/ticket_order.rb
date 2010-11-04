class TicketOrder < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  
  has_many :ticket_order_details, :dependent => :destroy
  
  default_scope :order => 'created_at DESC'
end
