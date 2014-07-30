class AddExactMatchToEventRequests < ActiveRecord::Migration
  def change
    add_column :event_requests, :exact_match, :boolean
  end
end
