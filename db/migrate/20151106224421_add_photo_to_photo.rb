class AddPhotoToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :photo, :json
  end
end
