class CreateAlbumImages < ActiveRecord::Migration[6.1]
  def change
    create_table :album_images do |t|
      t.string :slug

      t.timestamps
    end
    add_index :album_images, :slug, unique: true
  end
end
