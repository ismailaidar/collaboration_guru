class CreateRoleEnum < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE TYPE role_type AS ENUM ('admin', 'project_manager', 'team_member');
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE role_type;
    SQL
  end
end
