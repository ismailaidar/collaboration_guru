class AddUniqueIndexToProjectAssignments < ActiveRecord::Migration[7.1]
  def change
    add_index :project_assignments, %i[user_id project_id], unique: true
  end
end
