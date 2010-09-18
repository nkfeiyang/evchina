class CreateHostInfos < ActiveRecord::Migration
  def self.up
    create_table :host_infos do |t|

      t.timestamps
      t.string :name
      t.string :desc
      t.string :user_id
    end
  end

  def self.down
    drop_table :host_infos
  end
end
