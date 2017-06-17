FactoryGirl.define do
  factory :post do
    content "THIS IS MY TEST POST CONTENT."
    #belongs_to :user
    association :user
  end
end