class RemovePostIdFromEvent < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :post_id, :bigint
  end
end
