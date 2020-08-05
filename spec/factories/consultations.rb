FactoryBot.define do
  factory :consultation do
    content { "相談内容" }
    reservation_status { 0 }
    association :client, strategy: :create
    association :expert, strategy: :create
    association :event, strategy: :create
    association :trouble_tag, strategy: :create
  end
end
