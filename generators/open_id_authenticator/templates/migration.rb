class <%= migration_name %> < ActiveRecord::Migration
  def self.up
    add_column :users, :identity_url, :string, :limit => 155
    add_index :users, :identity_url, :unique => true
  end

  def self.down
    remove_column :users, :identity_url
    remove_index :users, :identity_url
  end
end
