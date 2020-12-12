class CreateUserJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :user_jobs do |t|
      t.string :status
      t.references :job, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
