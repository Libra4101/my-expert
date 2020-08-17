class Job < ApplicationRecord
  # association
  has_one :expert

  # validate
  validates :title, presence: true
  validates :content, presence: true, length: { maximum: 250 }
end
