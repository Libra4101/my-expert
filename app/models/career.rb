class Career < ApplicationRecord
  # association
  belongs_to :expert

  # validate
  validates :occurrence_date, presence: true
  validates :content, presence: true, uniqueness: true
end
