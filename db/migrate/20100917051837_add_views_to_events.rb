class AddViewsToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :views, :integer    #浏览次数
    add_column :events, :score, :integer    #评分
  end

  def self.down
    remove_column :events, :score
    remove_column :events, :views
  end
end
