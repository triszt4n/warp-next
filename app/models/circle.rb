class Circle < ApplicationRecord
  has_many :users, through: :memberships
  has_many :albums
end
