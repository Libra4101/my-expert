class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.references :expert, foreign_key: true, null: false
      t.references :problem, foreign_key: true, null: false

      t.timestamps
      t.index [:expert_id, :problem_id], unique: true
    end
  end
end
