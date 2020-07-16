class Comment < ApplicationRecord
  # association
  belongs_to :problem
  belongs_to :client, optional: true
  belongs_to :expert, optional: true
end
