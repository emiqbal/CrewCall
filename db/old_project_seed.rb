require_relative 'scraping'

def old_project_seed
  title = scraping_project

  5.times do |n|
    puts "Creating Project using seed..."
    project = Project.new(
      title: title.first[:title],
      description: title.first[:description],
      user: User.where(is_producer: true).sample,
      start_date: DateTime.parse("#{n+n+1}/12/2020 17:00"),
      end_date: DateTime.parse("#{n+n+2}/12/2020 17:00"),
      )
    file = URI.open("https://source.unsplash.com/random?film,video")
    project.photo.attach(io: file, filename: "#{title.first[:title]}.png", content_type: 'image/png')
    project.save!
    title.shift
  end

  puts "Project Seeding done!"
end
