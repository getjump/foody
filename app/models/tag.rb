class Tag < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_name, :against => :name, :using =>
    {
      :tsearch =>
        {
          :prefix => true
        }
    }

  has_many :foods, through: :food_tags
  has_many :food_tags
end
