class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.references :post, null: false, foreign_key: true
      t.datetime :date
      t.integer :event_type_id

      t.timestamps
    end
  end
end
