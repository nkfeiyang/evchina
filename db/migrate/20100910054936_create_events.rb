class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|

      t.timestamps
      t.string :title
      t.text :content
      t.datetime :start_time
      t.string :address
      t.string :zipcode
      t.string :telnumber
      t.string :contact_user_name
      t.string :email
      t.string :url
      t.integer :user_id
      t.string :event_logo_url
      t.string :status
      t.integer :category_id
      t.integer :host_info_id
    end
  end

  def self.down
    drop_table :events
  end
end
