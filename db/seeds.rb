# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"
require_relative 'scraping'

puts 'Clearing Database...'
Job.destroy_all
Project.destroy_all
# User.destroy_all

puts 'Clearing Database done!'

# profile = 'https://www.flaticon.com/svg/static/icons/svg/599/599305.svg'
# people = %w[syakiran iqbal josh rupert grace]
# random_boolean = [true, false].sample

# people.each do |person|
#   pic = URI.open(profile)
#   puts "Creating User using seed..."
#   user = User.new(
#     username: "#{person}",
#     email: "#{person}@gmail.com",
#     password: "123456",
#     is_producer: random_boolean
#     )

#   user.photo.attach(io: pic, filename: "#{person}.png", content_type: 'image/png')
#   user.save!
# end
# puts "User Seeding done!"

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
