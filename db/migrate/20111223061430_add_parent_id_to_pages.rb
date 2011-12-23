class AddParentIdToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :parent_id, :integer, :default => nil
  end

  def self.down
    remove_column :pages, :parent_id
  end
end
