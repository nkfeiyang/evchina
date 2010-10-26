class CreateUserFavEvents < ActiveRecord::Migration
  def self.up
    create_table :user_fav_events do |t|    # 本表保存用户收藏的事件id
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end
    add_index :user_fav_events, :user_id
    add_index :user_fav_events, :event_id
  end

  def self.down
    drop_table :user_fav_events
  end
end
