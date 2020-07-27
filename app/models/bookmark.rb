class Bookmark < ApplicationRecord
  belongs_to :expert
  belongs_to :problem
  validates :expert_id, uniqueness: { scope: :problem_id }
end
