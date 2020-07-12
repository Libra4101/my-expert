class TroubleTag < ApplicationRecord
  # association
  has_many :expertise_tags
  has_one :problem
end
