class EventRequest < ActiveRecord::Base
  belongs_to :event
  belongs_to :request
end
