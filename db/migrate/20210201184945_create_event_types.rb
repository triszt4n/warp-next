class CreateEventTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :event_types do |t|
      t.string :name
      t.json :form_data

      t.timestamps
    end
  end
end
