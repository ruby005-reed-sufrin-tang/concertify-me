# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :artist_request, :class => 'ArtistRequests' do
    request_id 1
    artist_id 1
  end
end
