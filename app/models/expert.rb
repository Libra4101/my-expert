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
end