class AddTestDataCategory < ActiveRecord::Migration
  def self.up
    Category.delete_all
    Category.create(:name => '教学活动', :show_order => 1)
    Category.create(:name => '商业会议', :show_order => 2)
    Category.create(:name => '商务活动', :show_order => 3)
    Category.create(:name => '网络活动', :show_order => 4)
    Category.create(:name => '社会事件', :show_order => 5)
    Category.create(:name => '艺术娱乐', :show_order => 6)
  end

  def self.down
    Category.delete_all
  end
end
