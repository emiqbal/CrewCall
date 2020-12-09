# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Clearing Database...'
Job.destroy_all
Project.destroy_all
User.destroy_all

profile = 'https://www.flaticon.com/svg/static/icons/svg/599/599305.svg'
people = %w[syakiran iqbal josh rupert grace]
random_boolean = [true, false].sample

people.each do |person|
  pic = URI.open(profile)
  puts "Creating User using seed..."
  user = User.new(
    username: "#{person}",
    email: "#{person}@gmail.com",
    password: "123456",
    is_producer: random_boolean
    )

  user.photo.attach(io: pic, filename: "#{person}.png", content_type: 'image/png')
  user.save!
end
puts "User Seeding done"


