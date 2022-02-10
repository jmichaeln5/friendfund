FactoryBot.define do
  factory :user do
    first_name { "yeets" }
    last_name { "mcgee" }
    phone_number { "954-342-5938" }
    email { "bigyeeterhausin@gmail.com" }
    username { "bigyeeterhausin" }
    password { "123456" }
    password_confirmation { "123456" }
  end
end
