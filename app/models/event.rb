class Event < ActiveRecord::Base
  has_many :event_requests
  has_many :requests, through: :event_requests
  has_many :event_users
  has_many :users, through: :event_users
  has_many :artist_events
  has_many :artists, through: :artist_events

  def self.top_events
    ActiveRecord::Base.connection.execute("SELECT events.title, events.id, count(*) as count FROM events JOIN event_users ON event_users.event_id = events.id WHERE events.location = 'New York, NY' GROUP BY events.title, events.id ORDER BY count DESC LIMIT 5")
  end
end
