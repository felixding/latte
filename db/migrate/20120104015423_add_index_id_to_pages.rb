class AddIndexIdToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :index_id, :integer, :null => false
  end

  def self.down
    remove_column :pages, :index_id
  end
end
