class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :project_id
      t.integer :creator_id
      t.integer :updater_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
