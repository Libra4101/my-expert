class ExpertiseTag < ApplicationRecord
  # association
  belongs_to :expert
  belongs_to :trouble_tags
end
