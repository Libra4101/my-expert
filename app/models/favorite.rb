class Favorite < ApplicationRecord
  # association
  belongs_to :client
  belongs_to :expert
end
