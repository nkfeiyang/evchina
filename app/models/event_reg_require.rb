class EventRegRequire < ActiveRecord::Base
  belongs_to :event
  belongs_to :sys_reg_info
  
end
