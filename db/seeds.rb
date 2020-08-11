# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Development
if Rails.env.development?

  Admin.create!(
    email: 'admin@example.com',
    password: 'password',
  )

  # Master Tabl
  [
      ['弁護士', '依頼を受けて法律事務を処理することを職務とする専門職'],
      ['税理士', '各種税金の申告・申請、税務書類の作成、税務相談、税に関する不服審査手続き等を行う専門職'],
      ['司法書士', '登記及び供託の代理、裁判所や検察庁、法務局、公証役場に提出する書類の作成提出、財産管理業務等を行う専門職']
  ].each do |job|
    Job.create!(
      title: job[0],
      content: job[1]
    )
  end

  [
    '債務整理',
    '相続・遺言',
    '消費者被害',
    '離婚・男女交際',
    '労働問題',
    '不動産登記',
    '会社登記',
    '交通事故',
    '成年後見',
    'その他'
  ].each do |nayami|
    TroubleTag.create!(
      name: nayami
    )
  end

  # Truncate Tabl
  Office.create!(
    name: '山本法律事務所',
    email: 'test@example.com',
    tel: '999-999-9999',
    postcode: '999-9999',
    address: '大阪府泉大津市池浦町',
    latitude: 34.498046,
    longitude: 135.413332,
    reception_start_time: Time.now,
    reception_end_time: Time.now + 2
  )

  Client.create!(
    email: 'hoge@example.com',
    password: 'password',
    name: '山田太郎',
    name_kana: 'ヤマダタロウ',
    gender: 1,
    age: '35',
    address: '大阪府泉大津市池浦町',
    postcode: '595-0022',
    phone_number: '999-999-9999'
  )

  1..15.times do |index|
    Expert.create!(
      email: "test#{index}@example.com",
      password: 'password',
      name: "山本太郎#{index}",
      name_kana: "ヤマモトタロウ#{index}",
      gender: 1,
      age: '45',
      phone_number: '999-999-9999',
      introduction: '自己紹介本文',
      public_status: true,
      office: Office.first,
      job: Job.first
    )

    Favorite.create!(
      client: Client.find_by(name: '山田太郎'),
      expert: Expert.find_by(name: "山本太郎#{index}")
    )
  end
 
  1..2.times do |idx|
    Problem.create!(
      client: Client.find_by(name: '山田太郎'),
      trouble_tag: TroubleTag.find_by(name: 'その他'),
      content: "#{idx}番目のお悩み　テストテストテストテストテストテストテストテストテストテスト",
      priority_status: 2
    )
    Comment.create!(
      problem: Problem.find_by(content: "#{idx}番目のお悩み　テストテストテストテストテストテストテストテストテストテスト"),
      expert: Expert.find_by(name: "山本太郎#{idx}"),
      content: "#{idx}番目のコメント　テストテストテストテストテストテストテストテストテストテスト"
    )
    Event.create!(
      title: "#{idx}番目の予約",
      start_event_time: DateTime.current,
      end_event_time: DateTime.current + 1
    )
    Consultation.create!(
      client: Client.find_by(name: '山田太郎'),
      expert: Expert.find_by(name: "山本太郎#{idx}"),
      trouble_tag: TroubleTag.find_by(name: 'その他'),
      event: Event.find_by(title: "#{idx}番目の予約"),
      content: "#{idx}番目の相談内容　テストテストテストテストテストテストテストテストテストテスト",
      reservation_status: 0
    )
  end
end

if Rails.env.production?
  # Master Tabl
  [
    ['弁護士', '依頼を受けて法律事務を処理することを職務とする専門職'],
    ['税理士', '各種税金の申告・申請、税務書類の作成、税務相談、税に関する不服審査手続き等を行う専門職'],
    ['司法書士', '登記及び供託の代理、裁判所や検察庁、法務局、公証役場に提出する書類の作成提出、財産管理業務等を行う専門職']
  ].each do |job|
    Job.create!(
      title: job[0],
      content: job[1]
    )
  end

  [
    '債務整理',
    '相続・遺言',
    '消費者被害',
    '離婚・男女交際',
    '労働問題',
    '不動産登記',
    '会社登記',
    '交通事故',
    '成年後見',
    'その他'
  ].each do |nayami|
    TroubleTag.create!(
      name: nayami
    )
  end

  # Truncate Tabl
  Office.create!(
    name: '山本総合事務所',
    email: 'test@example.com',
    tel: '999-999-9999',
    postcode: '999-9999',
    address: '大阪府泉大津市池浦町',
    latitude: 34.498046,
    longitude: 135.413332,
    reception_start_time: Time.now,
    reception_end_time: Time.now + 2
  )

  Client.create!(
    email: 'hoge@example.com',
    password: 'password',
    name: '山田太郎',
    name_kana: 'ヤマダタロウ',
    gender: 1,
    age: '35',
    address: '大阪府泉大津市池浦町',
    postcode: '595-0022',
    phone_number: '999-999-9999'
  )

  Expert.create!(
    email: "expert@example.com",
    password: 'password',
    name: "山本太郎",
    name_kana: "ヤマモトタロウ",
    gender: 1,
    age: '45',
    phone_number: '999-999-9999',
    introduction: '自己紹介本文',
    public_status: true,
    office: Office.first,
    job: Job.first
  )
  Expert.create!(
    email: "expert2@example.com",
    password: 'password',
    name: "山本次郎",
    name_kana: "ヤマモトジロウ",
    gender: 1,
    age: '42',
    phone_number: '999-999-9999',
    introduction: '自己紹介本文',
    public_status: true,
    office: Office.first,
    job: Job.second
  )
  Expert.create!(
    email: "expert3@example.com",
    password: 'password',
    name: "山本三郎",
    name_kana: "ヤマモトサブロウ",
    gender: 1,
    age: '40',
    phone_number: '999-999-9999',
    introduction: '自己紹介本文',
    public_status: true,
    office: Office.first,
    job: Job.third
  )
end