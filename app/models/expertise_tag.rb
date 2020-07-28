class ExpertiseTag < ApplicationRecord
  # association
  belongs_to :expert
  belongs_to :trouble_tag

  # validate
  validates :expert_id, presence: true
  validates :trouble_tag_id, presence: true
  validates :expert_id, uniqueness: { scope: :trouble_tag_id }
end
