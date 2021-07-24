# == Schema Information
#
# Table name: rents
#
#  id         :bigint           not null, primary key
#  end_date   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_rents_on_item_id  (item_id)
#  index_rents_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (user_id => users.id)
#
class Rent < ApplicationRecord
  belongs_to :item
  belongs_to :user
end
