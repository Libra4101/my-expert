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
    association :office, strategy: :create
    association :job, factory: :lawyer, strategy: :create
  end
  factory :expert_jiro, parent: :expert do
    email {"yamamotojirou@example.com"}
    name {"山本次郎"}
    name_kana {"ヤマモトジロウ"}
    age {42}
    association :job, factory: :taxation_accountant, strategy: :create
  end
  factory :expert_saburo, parent: :expert do
    email {"yamamotosaburo@example.com"}
    name {"山本三郎"}
    name_kana {"ヤマモトサブロウ"}
    age {38}
    association :job, factory: :judicial_scrivener, strategy: :create
  end
end
