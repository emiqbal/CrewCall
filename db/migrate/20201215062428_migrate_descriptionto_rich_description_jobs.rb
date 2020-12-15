class MigrateDescriptiontoRichDescriptionJobs < ActiveRecord::Migration[6.0]
 def up
    Job.find_each do |job|
      job.update(rich_description: job.description)
    end
  end

  def down
    Job.find_each do |job|
      job.update(description: job.rich_description)
      job.update(rich_description: nil)
    end
  end
end
