class AddVideolinkToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :videolink, :string
  end
end
