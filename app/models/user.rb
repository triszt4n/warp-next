class User < ApplicationRecord
  has_many :memberships
  has_many :circles, through: :memberships
end
