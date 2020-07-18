class Comment < ApplicationRecord
  # association
  belongs_to :problem
  belongs_to :client, optional: true
  belongs_to :expert, optional: true

  # validate
  validates :content, presence: true, length: { in: 1..3000 }

  # コメント投稿者判定
  def posted_expert?
    self.expert_id.present?
  end
  
  def posted_client?
    self.client_id.present?
  end
  
end
