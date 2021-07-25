class AddAuthorizationFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :authorized, :boolean, :default => false, :null => false
    add_column :users, :force_authorized, :boolean, :default => false, :null => false
    add_column :users, :admin, :boolean, :default => false, :null => false
  end
end
