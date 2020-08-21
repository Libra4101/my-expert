class Expert < ApplicationRecord
  # devise setting
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :password, :password_confirmation

  # image
  attachment :avater_image

  # association
  belongs_to :job, optional: true
  belongs_to :office, optional: true
  has_many :careers, dependent: :destroy
  has_many :expertise_tags, dependent: :destroy
  has_many :trouble_tags, through: :expertise_tags
  has_many :favorites
  has_many :clients, through: :favorites
  has_many :consultations
  has_many :events, through: :consultations
  has_many :comments, class_name: 'comment', foreign_key: 'expert_id'
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_problems, through: :bookmarks, source: :problem

  # enum
  enum gender: { sex_not_known: 0, male: 1, female: 2 }

  # validate
  validates :name,          presence: true, length: { maximum: 60 }
  validates :name_kana,     presence: true, length: { maximum: 75 }
  validates :phone_number,  presence: true, format: { with:/\A\d{3,4}-?\d{2,4}-?\d{4}\z/}
  validates :introduction, length: { maximum: 2500 }
  validates :age,           numericality: { only_integer: true }, allow_blank: true
  validates :job_id, presence: true
  validates :office_id, presence: true, unless: -> { validation_context == :new_save }

  # お気に入り確認
  def favorited_by?(client)
    self.favorites.where(client_id: client.id).exists?
  end

  # 公開ステータス名称を表示
  def public_status_name
    self.public_status ? "公開" : "非公開"
  end

  # 退会ステータス名称を表示
  def withdraw_status_name
    self.withdraw_status ? "登録中" : "退会済"
  end

  # ゲスト専門家
  def self.guest
    guest_job = Job.find_or_create_by!(title: "弁護士") do |job|
      job.content = "依頼を受けて法律事務を処理することを職務とする専門職"
    end

    guest_office = Office.find_or_create_by!(email: "guest-office@example.com") do |office|
      office.name = '法律事務所'
      office.email = 'guest-office@example.com'
      office.tel = '090-999-9999'
      office.postcode = '595-0022'
      office.address = '大阪府泉大津市池浦町'
      office.latitude = 34.498046
      office.longitude = 135.413332
      office.reception_start_time = Time.now
      office.reception_end_time = Time.now + 2
    end

    guest_expert = find_or_create_by!(email: 'guest-expert@example.com') do |expert|
      expert.password = SecureRandom.urlsafe_base64
      expert.name = '山下太郎'
      expert.name_kana = 'ヤマシタタロウ'
      expert.gender = 1
      expert.age = '56'
      expert.phone_number = '090-999-9999'
      expert.introduction = '自己紹介文'
      expert.public_status = false
      expert.job_id = guest_job.id
      expert.office_id = guest_office.id
    end

    return guest_expert
  end
end