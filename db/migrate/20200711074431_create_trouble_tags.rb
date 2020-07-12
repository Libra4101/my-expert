class CreateTroubleTags < ActiveRecord::Migration[5.2]
  def change
    create_table :trouble_tags do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
