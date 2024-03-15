class AddEndDateConstraintToProjects < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      ALTER TABLE projects
      ADD CONSTRAINT end_date_after_start_date_check
      CHECK (end_date > start_date);
    SQL
  end

  def down
    execute <<-SQL
    ALTER TABLE projects
    DROP CONSTRAINT end_date_after_start_date_check;
    SQL
  end
end
