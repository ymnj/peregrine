class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :country
      t.string :city
      t.date :start_date
      t.date :end_date
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
