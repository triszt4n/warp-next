class Circle < ApplicationRecord
  has_one_attached :logo
  validates :name, presence: true, length: { minimum: 3, maximum: 128 }

  has_many :memberships
  has_many :users, through: :memberships
  has_many :albums

  def mini
    if logo.nil?
      ActionController::Base.helpers.image_url('logo-blank-mini.png')
    else
      logo.variant gravity: 'Center', resize_to_limit: [36, 36]
    end
  end
end
