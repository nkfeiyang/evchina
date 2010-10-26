class CreateUserFavEvents < ActiveRecord::Migration
  def self.up
    create_table :user_fav_events do |t|
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
