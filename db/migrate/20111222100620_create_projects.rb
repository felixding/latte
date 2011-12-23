class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :creator_id
      t.integer :updater_id
      t.string :name
      t.text :intro
      t.string :subdomain

      t.timestamps
    end
  end
end
