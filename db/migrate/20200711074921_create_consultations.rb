class CreateConsultations < ActiveRecord::Migration[5.2]
  def change
    create_table :consultations do |t|
      t.references :client, null: false
      t.references :expert, null: false
      t.references :trouble_tag
      t.references :event
      t.text :content
      t.integer :reservation_status, default: 0

      t.timestamps
    end
  end
end
