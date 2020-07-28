class Office < ApplicationRecord
  # association
  has_one :expert

  # geocode
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
