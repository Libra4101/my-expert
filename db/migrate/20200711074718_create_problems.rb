class CreateProblems < ActiveRecord::Migration[5.2]
  def change
    create_table :problems do |t|
      t.references :client, null: false
      t.references :trouble_tag
      t.text :content
      t.integer :priority_status

      t.timestamps
    end
  end
end
