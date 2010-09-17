class AddIntroToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :intro, :string
  end

  def self.down
    remove_column :events, :intro
  end
end
