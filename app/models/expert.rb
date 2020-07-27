class Expert < ApplicationRecord
  # devise setting
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # image
  attachment :avater_image

  # association
  belongs_to :job
  belongs_to :office
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
  validates :phone_number,  presence: true, length: { maximum: 25 }
  validates :introduction, length: { maximum: 2500 }
  validates :withdraw_status, presence: true

  # お気に入り確認
  def favorited_by?(client)
    self.favorites.where(client_id: client.id).exists?
  end
end