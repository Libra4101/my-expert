FactoryBot.define do
  factory :expertise_tag do
    association :expert, strategy: :create
    association :trouble_tag, strategy: :create
  end
end
