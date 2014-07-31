# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :artist_event, :class => 'ArtistEvents' do
    artist_id 1
    event_id 1
  end
end
