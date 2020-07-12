class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.references :client, null: false
      t.references :expert, null: false

      t.timestamps
    end
  end
end
