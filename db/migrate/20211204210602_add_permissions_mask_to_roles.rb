class AddPermissionsMaskToRoles < ActiveRecord::Migration[6.1]
  def change
    add_column :roles, :permissions_mask, :integer
  end
end
