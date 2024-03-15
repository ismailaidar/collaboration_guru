class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :description
      t.date :start_date
      t.date :end_date
      t.string :status

      t.timestamps
    end
  end
end
