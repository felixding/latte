class RemoveParentIdFromPages < ActiveRecord::Migration
  def self.up
    remove_column :pages, :parent_id
  end

  def self.down
    add_column :pages, :parent_id, :integer
  end
end
