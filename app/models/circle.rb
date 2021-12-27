class Circle < ApplicationRecord
  has_one_attached :logo
  validates :name, presence: true, length: { minimum: 3, maximum: 128 }

  has_many :users, through: :memberships
  has_many :albums

  def thumbnail
    if logo.nil?
      ActionController::Base.helpers.image_url('album-blank.jpg')
    else
      logo.variant gravity: 'Center', resize: '300x200^', crop: '300x200+0+0'
    end
  end
end
