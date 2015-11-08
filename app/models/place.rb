class Place < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_name, :against => :name, :using =>
    {
      :tsearch =>
        {
          :prefix => true
        }
    }
end
