FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    school "UCLA"
    company "Brunchwork"
    work_position "Engineer"
    password "foobar"
    password_confirmation "foobar"
    
    factory :admin do
      admin true
    end
  end
  
  factory :event do
    about "Lorem ipsum"
    title "Brunchwork Event"
    location "New York, New York"
    date_time Time.now
    event_type "brunchstory"
  end
end