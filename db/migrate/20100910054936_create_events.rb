class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events, :force => true do |t|

      t.timestamps
      t.string :title,:null=>false
      t.text :intro
      t.text :content,:null=>false
      t.datetime :start_time,:null=>false
      t.datetime :end_time,:null=>false
      t.string :address
      t.float :map_x    # 百度map的x坐标
      t.float :map_y    # 百度map的y坐标
      t.string :zipcode
      t.string :telnumber
      t.string :contact_user_name
      t.string :email
      t.string :web_url
      t.integer :user_id,:null=>false
      t.string :event_logo_url
      t.string :status
      t.integer :category_id,:null=>false
      t.integer :city_id,:null=>false          # 城市编号
      t.text :hostinfo            # 发布方的信息。
      t.integer :views,:default=>0            # 浏览次数
      t.integer :score,:default=>0            # 评分
      t.decimal :price,:scale=>2            # 票价格，0表示免费
      t.boolean :each_need_reginfo,:defalut=>false #是否每张票都需要单独收集参会者信息
      t.boolean :is_other_site,:defalut=>false    # 是否来源于外站（即订票时，直接跳转到外站）
      t.string  :other_site_name   # 外站名称
      t.string  :other_event_url   # 如果来源于外站，那订票时直接跳转到该站点的地址。
      t.integer :sold_tickets,:defalut=>0     # 已预订的票数
      t.integer :total_tickets,:defalut=>0    # 总的票数   0表示不限
      
    end
  end

  def self.down
    drop_table :events
  end
end
