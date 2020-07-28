class AverageCache < ActiveRecord::Base
  belongs_to :rater, :class_name => "Client"
  belongs_to :rateable, :polymorphic => true
end
