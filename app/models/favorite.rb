class Favorite < ApplicationRecord
  # association
  belongs_to :client
  belongs_to :expert

  # validate
  validates :expert_id, presence: true
  validates :client_id, presence: true
end
