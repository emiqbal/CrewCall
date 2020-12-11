class AddDepartmentToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :department, :string
  end
end
