class Food < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_name, :against => :name, :using =>
    {
      :tsearch =>
        {
          :prefix => true
        }
    }

  attr_accessor :groupStr

  scope :top, -> {
    Food.joins('LEFT JOIN ratings ON ratings.food_id = foods.id').select('foods.*, COUNT(ratings.id) AS votes_count').group("foods.id").order('votes_count DESC')
  }

  attr_accessor :user

  belongs_to :photo
  has_many :tags, through: :food_tags
  has_many :ratings
  has_many :food_tags
  belongs_to :place

  def ratings_count
    liked_count = Rating.where(:food => self, :status => 1).count
    tried_count = Rating.where(:food => self, :status => 0).count

    return {:tried => tried_count + liked_count, :liked => liked_count}
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
