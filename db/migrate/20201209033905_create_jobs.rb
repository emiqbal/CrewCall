class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.text :description
      t.integer :salary
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
