FactoryBot.define do
  factory :favorite do
    association :client, strategy: :create
    association :expert, strategy: :create
  end
end
