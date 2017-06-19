FactoryGirl.define do
  factory :user do
    name "MyString"
    sequence(:username) { |i| "username#{i}" }
    sequence(:password) { |i| "password#{i}"}
    posts { |post| []}

    # factory :user_same_un_and_pwd do
    #   name {"username"}
    #   password {"password"}
    # end

    # factory :user_same_auth_token do
    #   auth_token {"auth_token"}
    # end
  end
end