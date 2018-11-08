class Rating < ActiveRecord::Base
  scope :tried, -> { where(:status => 0) }
  scope :liked, -> { where(:status => 1) }


  belongs_to :food
  belongs_to :user
end
