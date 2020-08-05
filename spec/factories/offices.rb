FactoryBot.define do
  factory :office do
    name { "山本総合事務所" }
    email { "test@example.com" }
    tel { "090-999-9999" }
    postcode { "999-9999" }
    address { "大阪府泉大津市池浦町" }
    latitude { 34.498046 }
    longitude { 135.413332 }
    reception_start_time { Time.now }
    reception_end_time { Time.now + 2 }
  end
end
