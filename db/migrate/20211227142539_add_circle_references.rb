class AddCircleReferences < ActiveRecord::Migration[6.1]
  def change
    add_reference :albums, :circle
    add_reference :users, :circle
  end
end
