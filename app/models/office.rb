class Office < ApplicationRecord
  # association
  has_one :expert

  # geocode
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  # validate
  validates :name,          presence: true, length: { maximum: 60 }
  validates :email,         presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  validates :tel,  format: { with:/\A\d{3,4}-?\d{2,4}-?\d{4}\z/}
  validates :postcode,      format: { with:/\A\d{3}-?\d{4}\z/}
  validates :address,       length: { maximum: 160 }
  validates :reception_start_time, presence: true
  validates :reception_end_time,   presence: true
end
