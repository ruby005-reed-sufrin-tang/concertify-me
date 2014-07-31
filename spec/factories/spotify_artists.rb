# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :spotify_artist, :class => 'SpotifyArtists' do
    name "MyString"
    user_id 1
  end
end
