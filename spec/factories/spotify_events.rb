# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :spotify_event do
    title "MyString"
    datetime "2014-07-31 17:35:52"
    formatted_datetime "MyString"
    location "MyString"
    ticket_url "MyString"
    facebook_rsvp_url "MyString"
  end
end
