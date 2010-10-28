# 记录事件发布者希望收集的参会者的信息项
class CreateEventRegRequires < ActiveRecord::Migration
  def self.up
    create_table :event_reg_requires do |t|

      t.timestamps
      t.integer :event_id   # event id
      t.integer :sys_reg_info_id # sys_reg_info id
      t.boolean :required   #是否必须填写
    end
  end

  def self.down
    drop_table :event_reg_requires
  end
end
