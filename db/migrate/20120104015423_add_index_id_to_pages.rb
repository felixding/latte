class AddIndexIdToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :index_id, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :pages, :index_id
  end
end
