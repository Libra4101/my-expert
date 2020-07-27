class CreateOffices < ActiveRecord::Migration[5.2]
  def change
    create_table :offices do |t|
      t.string :name
      t.string :email
      t.string :tel
      t.string :postcode
      t.string :address
      t.float :latitude
      t.float :longitude
      t.time :reception_start_time
      t.time :reception_end_time

      t.timestamps
    end
  end
end
