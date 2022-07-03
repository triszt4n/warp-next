class Album < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3, maximum: 128 }
  validates :desc, length: { maximum: 255 }
  belongs_to :user
  belongs_to :circle
  has_many :album_images, dependent: :destroy, autosave: true

  def thumbnail
    if album_images.empty?
      ActionController::Base.helpers.image_url('album-blank.jpg')
    else
      album_images.first.file.variant gravity: 'Center', resize: '300x200^', crop: '300x200+0+0'
    end
  end

  def images
    album_images
  end

  def build_images(images)
    return if images.blank?

    images.each do |image|
      album_images.build(file: image)
    end
  end
end
