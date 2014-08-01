class RemoveColumnFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :spotify_event, :string
  end
end
