FactoryBot.define do
  factory :problem do
    content { "お悩み内容" }
    priority_status { 1 }
    association :client, strategy: :create
    association :trouble_tag, strategy: :create
  end
end
