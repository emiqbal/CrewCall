class MigrateDescriptiontoRichDescriptionProjects < ActiveRecord::Migration[6.0]
  def up
    Project.find_each do |project|
      project.update(rich_description: project.description)
    end
  end

  def down
    Project.find_each do |project|
      project.update(description: project.rich_description)
      project.update(rich_description: nil)
    end
  end
end
