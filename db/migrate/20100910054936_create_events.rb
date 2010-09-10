class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|

      t.timestamps
      t.string :title
      t.string :content
      t.datetime :start_time
      t.string :address
      t.integer :user_id
      t.string :event_logo_url
      t.string :status
      t.integer :category_id
    end
  end

  def self.down
    drop_table :events
  end
end
