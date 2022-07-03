namespace :data_migrate do
  desc 'Migrate album attached images to new AlbumImage model'
  task images: :environment do
    class TempAlbumImage < ApplicationRecord
      extend FriendlyId
      belongs_to :album, class_name: 'TempAlbum'
      has_one_attached :file
      friendly_id :filename, use: :slugged
      self.table_name = 'album_images'
      private

      def filename
        file.filename.to_s
      end
    end

    class TempAlbum < ApplicationRecord
      has_many_attached :images
      self.table_name = 'albums'

      has_many :album_images, class_name: 'TempAlbumImage', foreign_key: 'album_id'
    end


    ActiveRecord::Base.transaction do
      puts 'Running album migration for new album_image models defined in 2022-07-03'
      ActiveStorage::Attachment.where(record_type: "Album").update_all("record_type = 'TempAlbum'")
      puts "Migrating #{TempAlbum.all.sum { |album| album.images.length }} images"
      puts TempAlbum.first.album_images.count
      TempAlbum.all.each do |album|
        album.images.each do |image|
          new_img = album.album_images.build(file: image.blob)
          new_img.save
        end
      end
      ActiveStorage::Attachment.where(record_type: 'TempAlbumImage').update_all("record_type = 'AlbumImage'")
      ActiveStorage::Attachment.where(record_type: 'TempAlbum').delete_all
    end
    puts 'Migration done'

  end
end
