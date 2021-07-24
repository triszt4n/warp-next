class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :short_description
      t.integer :static_id

      t.timestamps
    end
  end
end
