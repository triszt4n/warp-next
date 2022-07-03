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
