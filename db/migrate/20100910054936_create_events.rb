class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|

      t.timestamps
      t.string :title
      t.text :intro
      t.text :content
      t.datetime :start_time
      t.datetime :end_time
      t.string :address
      t.string :zipcode
      t.string :telnumber
      t.string :contact_user_name
      t.string :email
      t.string :web_url
      t.integer :user_id
      t.string :event_logo_url
      t.string :status
      t.integer :category_id
      t.text :hostinfo            # 发布方的信息。
      t.integer :views            # 浏览次数
      t.integer :score            # 评分
      t.decimal :price            # 票价格，0表示免费
      t.boolean :each_need_reginfo #是否每张票都需要单独收集参会者信息
      t.integer :sold_tickets     # 已预订的票数 
      t.integer :total_tickets    # 总的票数   0表示不限
      
    end
  end

  def self.down
    drop_table :events
  end
end
