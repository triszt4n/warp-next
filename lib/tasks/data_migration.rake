namespace :data_migrate do
  desc 'Migrate album attached images to new AlbumImage model'
  task :images => :environment do

    module AlbumMigrator

      class AlbumImage < ApplicationRecord
        extend FriendlyId
        belongs_to :album
        has_one_attached :file
        friendly_id :filename, use: :slugged

        private

        def filename
          file.filename.to_s
        end
      end

      class Album < ApplicationRecord
        has_many_attached :images
        belongs_to :user
        belongs_to :circle
        has_many :album_images, dependent: :destroy

      end

      class MigrateAlbumToNewModels
        def self.call
          puts 'Running album migration for new album_image models defined in 2022-07-03'
          puts "Migrating #{Album.all.sum { |album| album.images.length }} images"
          ActiveRecord::Base.transaction do
            Album.all.each do |album|
              album.images.each do |image|
                new_img = album.album_images.build(file: image.blob)
                new_img.save
              end
            end
          end
          puts 'Migration done'
        end
      end

    end

    AlbumMigrator::MigrateAlbumToNewModels.call
  end
end

