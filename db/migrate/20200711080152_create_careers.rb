class CreateCareers < ActiveRecord::Migration[5.2]
  def change
    create_table :careers do |t|
      t.references :expert, null: false
      t.date :occurrence_date, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
