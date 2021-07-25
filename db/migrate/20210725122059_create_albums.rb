class CreateAlbums < ActiveRecord::Migration[6.1]
  def change
    create_table :albums do |t|
      t.string :title, default: "Untitled", null: false
      t.string :desc
      t.boolean :shared, default: true, null: false
      t.boolean :public, default: true, null: false
      t.string :tag

      t.timestamps
    end
  end
end
