class Food < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  attr_accessor :user

  belongs_to :photo
  has_many :tags, through: :food_tags
  has_many :food_tags
  belongs_to :place

  def ratings
    tried = Rating.where(:food => self, :status => 0).count
    liked = Rating.where(:food => self, :status => 1).count

    return {:tried => tried, :liked => liked}
  end

  def likes
    unless user.nil?
      rating = Rating.where(:user => user, :food => self).take
      unless rating.nil?
        return LikesRepresenter.new(rating)
      end
    end
  end
end
