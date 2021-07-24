class AddIndexToPostId < ActiveRecord::Migration[6.0]
  def change
    add_index :albums, :post_id, :unique => true
  end
end
