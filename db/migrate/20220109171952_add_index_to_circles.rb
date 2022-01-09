class AddIndexToCircles < ActiveRecord::Migration[6.1]
  def change
    add_index :circles, :name, unique: true
  end
end
