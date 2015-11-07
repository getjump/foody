class AddPhotoToPhoto < ActiveRecord::Migration
  def self.up
    add_attachment :photos, :photo
  end

  def self.down
    add_attachment :photos, :photo
  end
end
