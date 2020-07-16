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
  has_many :expertise_tags
  has_many :trouble_tags, through: :expertise_tags
  has_many :favorites
  has_many :clients, through: :favorites
  has_many :consultations
  has_many :events, through: :consultations
  has_many :comments, class_name: 'comment', foreign_key: 'expert_id'

  # enum
  enum gender: { sex_not_known: 0, male: 1, female: 2 }
end