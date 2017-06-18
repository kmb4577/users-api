FactoryGirl.define do
  factory :user do
    name "MyString"
    sequence(:username) { |i| "username#{i}" }
    sequence(:password) { |i| "password#{i}"}
    # sequence(:auth_token) { |i| "auth_token#{i}"}
    posts { |post| []}

    factory :user_same_un_and_pwd do
      name {"username"}
      password {"password"}
    end

    # factory :user_same_auth_token do
    #   auth_token {"auth_token"}
    # end

    # username { Faker::Lorem.word } #"MyString"
    #By wrapping faker methods in a block, we ensure that faker generates
    # dynamic data every time the factory is invoked.
    # This way, we always have unique data.
    # password { Faker::Lorem.word } #"MyString"
  end
end