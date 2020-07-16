class Consultation < ApplicationRecord
  # association
  belongs_to :client
  belongs_to :expert
  belongs_to :trouble_tag
  belongs_to :event

  # enum
  enum reservation_status: { applying: 0, reservations: 1, completed: 2 }

  # 相談内容検索
  def self.search(keyword)
    return Consultation.all unless keyword
    Consultation.where('content LIKE ?', "%#{sanitize_sql_like(keyword)}%")
  end
end
