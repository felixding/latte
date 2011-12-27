class CreateEditions < ActiveRecord::Migration
  def change
    create_table :editions do |t|
      t.integer :project_id
      t.integer :creator_id
      t.integer :project_version
      t.text :pages
      t.string :name
      t.text :intro

      t.timestamps
    end
  end
end
