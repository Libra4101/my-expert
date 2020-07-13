class Consultation < ApplicationRecord
  # association
  belongs_to :client
  belongs_to :expert
  belongs_to :trouble_tag
  has_many :events, dependent: :destroy
end
