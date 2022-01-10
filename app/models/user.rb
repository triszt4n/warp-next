class User < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :circles, through: :memberships
end
