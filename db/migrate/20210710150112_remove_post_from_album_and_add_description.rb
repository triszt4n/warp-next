class RemovePostFromAlbumAndAddDescription < ActiveRecord::Migration[6.0]
  def change
    remove_column :albums, :post_id, :integer
    add_column :albums, :short_desc, :string
    add_column :albums, :date, :date
    add_column :albums, :title, :string, :limit => 128
  end
end
