class AddTitleAndBodyToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :title, :string
    add_column :trips, :body, :text
  end
end
