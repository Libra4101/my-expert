FactoryBot.define do
  factory :job do
    title { "専門職" }
    content { "専門職の説明" }
  end
  factory :lawyer, class: Job do
    title { "弁護士" }
    content { "依頼を受けて法律事務を処理することを職務とする専門職" }
  end
  factory :taxation_accountant, class: Job do
    title { "税理士" }
    content { "各種税金の申告・申請、税務書類の作成、税務相談、税に関する不服審査手続き等を行う専門職" }
  end
  factory :judicial_scrivener, class: Job do
    title { "司法書士" }
    content { "登記及び供託の代理、裁判所や検察庁、法務局、公証役場に提出する書類の作成提出、財産管理業務等を行う専門職" }
  end
end
