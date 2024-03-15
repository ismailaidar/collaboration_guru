class AddRoleToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :role_type
  end
end
