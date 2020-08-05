FactoryBot.define do
  factory :expert do
    email {"yamamoto@example.com"}
    password {"password"}
    name {"山本太郎"}
    name_kana {"ヤマモトタロウ"}
    gender {0}
    age {45}
    phone_number {"090-9999-9999"}
    introduction {"自己紹介本文"}
    public_status {true}
    withdraw_status {true}
    association :office
    association :job, factory: :lawyer
  end
end
