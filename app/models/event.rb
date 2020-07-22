class Event < ApplicationRecord
  # association
  has_one :consultation

  # validate
  validates :title, presence: true
  validates :start_event_time, presence: true
  validates :end_event_time, presence: true

end
