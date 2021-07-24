# == Schema Information
#
# Table name: events
#
#  id            :bigint           not null, primary key
#  date          :datetime
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  event_type_id :integer
#
require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
