class Consultation < ApplicationRecord
  # association
  belongs_to :client
  belongs_to :expert
  belongs_to :trouble_tag
  belongs_to :event

  # enum
  enum reservation_status: { applying: 0, reservations: 1, completed: 2 }

  # validate
  validates :trouble_tag_id, presence: true
  validates :client_id, presence: true
  validates :expert_id, presence: true
  validates :event_id, presence: true
  validates :content, presence: true, length: { maximum: 2500 }

  # 相談内容検索
  def self.search(keyword)
    return Consultation.all unless keyword
    Consultation.where('content LIKE ?', "%#{sanitize_sql_like(keyword)}%")
  end
end
