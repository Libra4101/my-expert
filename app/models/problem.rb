class Problem < ApplicationRecord
  # association
  belongs_to :client
  belongs_to :trouble_tags
end
