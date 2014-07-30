# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    title "MyString"
    datetime "2014-07-30 12:04:42"
    formatted_datetime "MyString"
    location "MyString"
    searched_artist_id 1
  end
end
