class AddAlbumIdToAlbumImage < ActiveRecord::Migration[6.1]
  def change
    add_reference :album_images, :album, null: false, foreign_key: true
  end
end
