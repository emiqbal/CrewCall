def job_seed
  projects = Project.all
  projects.each do |project|
    job = Job.new(
      title: "Production Assistant Driver",
      description: "Drive the Production truck throughout the shoot, and run errands",
      department: "Transport",
      start_date: project.start_date,
      end_date: project.end_date,
      salary: 15000,
      )
    job.project = project
    job.save!
  end
end
