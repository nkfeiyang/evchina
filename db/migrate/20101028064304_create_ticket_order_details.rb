# 本表保存报名用户的详细信息。如果一个用户报名时有多张票，且举办方要求每张票都有参会者信息，
# 这时，每个订单下会有多个ticket_order_small_id，记录每个参会者的信息
class CreateTicketOrderDetails < ActiveRecord::Migration
  def self.up
    create_table :ticket_order_details do |t|
      
      t.timestamps
      t.integer :ticket_order_id  # 关联表:ticket_orders的id
      t.integer :ticket_order_small_id # 从1开始。如果一个订单包含多张票，则此值可以大于1。
      t.integer :event_reg_require_id  # 关联表:event_reg_requires的id
      t.string  :reg_info_value   # 对应的参加活动用户的某个信息的值
    end
  end

  def self.down
    drop_table :ticket_order_details
  end
end
