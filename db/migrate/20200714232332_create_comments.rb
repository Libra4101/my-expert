class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :problem
      t.references :expert
      t.references :client
      t.text :content

      t.timestamps
    end
  end
end
