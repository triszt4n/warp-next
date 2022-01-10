class RemoveAdminFromUser < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :admin, :site_admin
    remove_column :users, :force_authorized, :boolean, null: false, default: false
  end
end
