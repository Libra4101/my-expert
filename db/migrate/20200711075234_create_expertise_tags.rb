class CreateExpertiseTags < ActiveRecord::Migration[5.2]
  def change
    create_table :expertise_tags do |t|
      t.references :expert, null: false
      t.references :trouble_tag, null: false

      t.timestamps
    end
  end
end
