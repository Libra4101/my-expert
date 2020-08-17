FactoryBot.define do
  factory :comment do
    content { "コメント内容" }
    association :problem, strategy: :create
    association :expert
    association :client
  end
end
