class AddIndexToParticipation < ActiveRecord::Migration[6.0]
  def change
    add_index :participations, [:event_id, :user_id], :unique => true
  end
end
