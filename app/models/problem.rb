class Problem < ApplicationRecord
  # association
  belongs_to :client
  belongs_to :trouble_tag
  has_many :comments

  # enum
  enum priority_status: { low: 0, middle: 1, high: 2, emergency: 3 }

  # validate
  validates :trouble_tag_id, presence: true
  validates :priority_status, presence: true
  validates :content, presence: true

  # 投稿者別コメント
  def expert_comments(expert_id: nil)
    if expert_id
      self.comments.where(expert_id: expert_id)
    else
      self.comments.where.not(expert_id: nil)
    end
  end
  def client_comments
    self.comments.where.not(client_id: nil)
  end

  # 投稿内容検索
  def self.search(keyword)
    return Problem.all unless keyword
    Problem.where('problems.content LIKE ?', "%#{sanitize_sql_like(keyword)}%")
  end
end
