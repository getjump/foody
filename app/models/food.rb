class Food < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  include PgSearch
  pg_search_scope :search_by_name, :against => :name, :using =>
    {
      :tsearch =>
        {
          :prefix => true,
          :threshold => 0.3
        }
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
