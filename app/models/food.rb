class Food < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :photo
  has_many :tags, through: :food_tags
  has_many :food_tags
  belongs_to :place

  def ratings
    tried = Rating.where(:food => self, :type => 0).count
    liked = Rating.where(:food => self, :type => 1).count

    return {:tried => tried, :liked => liked}
  end
end
