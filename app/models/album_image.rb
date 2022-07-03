class AlbumImage < ApplicationRecord
  extend FriendlyId
  belongs_to :album
  has_one_attached :file
  friendly_id :slug_candidates, use: :slugged

  private

  def slug_candidates
    [
      :filename,
      %i[filename extension],
      %i[album_name filename extension],
      %i[circle_name album_name filename extension]
    ]
  end

  def filename
    file.filename.base.to_s
  end

  def extension
    file.filename.extension_without_delimiter.to_s
  end

  def circle_name
    album.circle.name
  end

  def album_name
    album.title
  end
end
