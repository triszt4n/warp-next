# == Schema Information
#
# Table name: posts
#
#  id                :bigint           not null, primary key
#  title             :string
#  short_description :string
#  static_id         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Post < ApplicationRecord
  has_one :album
  has_rich_text :formatted_document
  enum static_id: [:common, :about]

  default_scope { where(static_id: :common) }
end
