class CreateCfgIndexEvents < ActiveRecord::Migration
  def self.up
    create_table :cfg_index_events do |t|
      t.integer :event_id
      t.integer :show_order           # 显示
      t.boolean    :is_valid             # 是否有效。
      t.string  :title                # 可选的标题。这可以使得标题与实际事件的标题有区别
      t.string  :desc                 # 可选的简介。可以使其与实际事件的简介不一样
      t.string  :img_url              # 可选的图像地址
      t.timestamps
    end
  end

  def self.down
    drop_table :cfg_index_events
  end
end
