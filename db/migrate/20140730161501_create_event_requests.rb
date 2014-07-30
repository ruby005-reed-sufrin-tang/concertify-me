class CreateEventRequests < ActiveRecord::Migration
  def change
    create_table :event_requests do |t|
      t.integer :request_id
      t.integer :event_id

      t.timestamps
    end
  end
end
