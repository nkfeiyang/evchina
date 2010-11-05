class CreateCities < ActiveRecord::Migration
  def self.up
    create_table :cities do |t|
      t.string  :ename          # 城市英文简称，不能重复，可以做key。
      t.string  :name           # 城市中文名称
      t.integer :show_order     # 显示编号
      t.timestamps
    end
  end

  def self.down
    drop_table :cities
  end
end
