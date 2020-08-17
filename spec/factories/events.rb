FactoryBot.define do
  factory :event do
    title { "相談予約" }
    start_event_time { Time.now }
    end_event_time { Time.now + 2 }
  end
end
