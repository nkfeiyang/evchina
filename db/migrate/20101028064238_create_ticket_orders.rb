class CreateTicketOrders < ActiveRecord::Migration
  def self.up
    create_table :ticket_orders do |t|

      t.timestamps
      t.integer :user_id        #关联 user id
      t.integer :event_id       #关联event id
      t.decimal :price          # 票单价
      t.integer :ticket_counts  #票的数量
    end
  end

  def self.down
    drop_table :ticket_orders
  end
end
