class AddWebUrlToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :web_url, :string
  end

  def self.down
    remove_column :events, :web_url
  end
end
