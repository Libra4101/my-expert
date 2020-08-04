FactoryBot.define do
  factory :client do
    email {"test@example.com"}
    password {"password"}
    name {"山本太郎"}
    name_kana {"ヤマモトタロウ"}
    gender {0}
    age {45}
    address {"大阪府泉大津市池浦町"}
    postcode {"999-9999"}
    phone_number {"090-9999-9999"}
    withdraw_status {true}
  end
end
