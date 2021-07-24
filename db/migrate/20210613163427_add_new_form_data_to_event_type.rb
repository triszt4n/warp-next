class AddNewFormDataToEventType < ActiveRecord::Migration[6.0]
  def change
    add_column :event_types, :schema, :string
    add_column :event_types, :uischema, :string
  end
end
