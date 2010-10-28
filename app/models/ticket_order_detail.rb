class TicketOrderDetail < ActiveRecord::Base
  belongs_to :ticket_order

  belongs_to :sys_reg_info
  
end
