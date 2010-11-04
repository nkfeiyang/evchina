class TicketOrderDetail < ActiveRecord::Base
  belongs_to :ticket_order

  belongs_to :sys_reg_info
  
  default_scope :order => 'ticket_order_id ASC, ticket_order_small_id ASC, sys_reg_info_id ASC'
end
