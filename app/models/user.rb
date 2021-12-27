class User < ApplicationRecord
  has_many :circles, through: :memberships
  has_many :memberships
end
