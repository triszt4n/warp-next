class CreateRents < ActiveRecord::Migration[6.0]
  def change
    create_table :rents do |t|
      t.datetime :end_date
      t.references :item, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
