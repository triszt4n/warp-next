desc 'Migrate album attached images to new AlbumImage model'
task :migrate_images => :environment do
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

  ActiveRecord::Base.transaction do
    Album.all.each do |album|
      album.images.each do |image|
        new_img = album.album_images.build(file: image.blob)
        new_img.save
      end
    end
  end
end
