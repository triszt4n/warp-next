# == Schema Information
#
# Table name: albums
#
#  id         :bigint           not null, primary key
#  date       :date
#  short_desc :string
#  title      :string(128)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Album < ApplicationRecord
  has_many_attached :images
  validates :title, presence: true, length: { minimum: 3, maximum: 128 }
  validates :short_desc, length: { maximum: 255 }

  def thumbnail
    if images.empty?
      ActionController::Base.helpers.image_url('blank-album.png')
    else 
      images.first.variant gravity: "Center", resize: "300x200^", crop: "300x200+0+0" 
    end
  end
end
