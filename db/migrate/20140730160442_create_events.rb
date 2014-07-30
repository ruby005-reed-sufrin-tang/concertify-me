class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :datetime
      t.string :formatted_datetime
      t.string :location
      t.integer :searched_artist_id

      t.timestamps
    end
  end
end
