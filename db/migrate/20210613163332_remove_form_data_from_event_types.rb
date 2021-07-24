class RemoveFormDataFromEventTypes < ActiveRecord::Migration[6.0]
  def change
    remove_column :event_types, :form_data, :json
  end
end
