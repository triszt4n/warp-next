class Album < ApplicationRecord
  has_many_attached :images
  validates :title, presence: true, length: { minimum: 3, maximum: 128 }
  validates :desc, length: { maximum: 255 }
  belongs_to :user
  belongs_to :circle

  def thumbnail
    if images.empty?
      ActionController::Base.helpers.image_url('album-blank.jpg')
    else
      images.first.variant gravity: 'Center', resize: '300x200^', crop: '300x200+0+0'
    end
  end

  def self.find_blob_owner(blob_id)
    Album.joins(:images_blobs).find_by(active_storage_blobs: { id: blob_id })
  end
end
