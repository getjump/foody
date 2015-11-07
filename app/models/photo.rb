require 'carrierwave/orm/activerecord'

class Photo < ActiveRecord::Base
  has_attached_file :photo, :default_url => "https://pp.vk.me/c627626/v627626270/20a3a/Vn0ltSG-bFE.jpg", styles: {
    thumb: '150x150>',
    square: '360x360#',
    medium: '450x450>'
  }
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  belongs_to :place

  has_one :food

  def fetch
    return { :original => photo(:original), :medium => photo(:medium), :thumb => photo(:thumb), :square => photo(:square) }
  end
end
