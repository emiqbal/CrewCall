class AddTitleToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :title, :string
  end
end
