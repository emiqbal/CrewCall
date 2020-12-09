class RemoveColumnsFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :department, :string
    remove_column :users, :company_name, :string
  end
end
