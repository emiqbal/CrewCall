require 'faker'

def project_seed

  5.times do |n|
    puts "Creating Project using seed..."
    project = Project.new(
      title: Faker::Movie.title,
      description: Faker::Movie.quote,
      user: User.where(is_producer: true).sample,
      start_date: DateTime.parse("#{n+n+1}/01/2021 17:00"),
      end_date: DateTime.parse("#{n+n+2}/01/2021 17:00"),
      )
    file = URI.open("https://source.unsplash.com/random?film,video")
    project.photo.attach(io: file, filename: "#{project.title}.png", content_type: 'image/png')
    project.save!
  end

  puts "Project Seeding done!"
end
