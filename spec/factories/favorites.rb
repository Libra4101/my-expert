FactoryBot.define do
  factory :favorite do
    association :client, strategy: :create
    association :expert, strategy: :create
  end
  factory :favorite_expert, class: Favorite do
    association :client
    association :expert
  end
end
