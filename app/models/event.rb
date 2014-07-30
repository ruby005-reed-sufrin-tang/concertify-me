class Event < ActiveRecord::Base
  has_many :event_requests
  has_many :requests, through: :event_requests
  has_many :event_users
  has_many :users, through: :event_users
end
