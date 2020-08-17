FactoryBot.define do
  factory :career do
    occurrence_date { Date.current }
    content { "司法試験合格" }
    association :expert
  end
end
