class Expert < ApplicationRecord
  # devise setting
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # association
  has_one  :job
  has_one  :office
  has_many :careers, dependent: :destroy
  has_many :expertise_tags
  has_many :particular_field, through: :expertise_tags
  has_many :favorites
  has_many :favorited_clients, through: :favorites
  has_many :consultations
  has_many :consultations_event, through: :consultations
end