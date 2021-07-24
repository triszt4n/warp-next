class AddFormDataToParticipations < ActiveRecord::Migration[6.0]
  def change
    add_column :participations, :form_data, :jsonb
  end
end
