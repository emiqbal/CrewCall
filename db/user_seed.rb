def user_seed
  people = %w[syakiran josh rupert grace]
  random_boolean = [true, false].sample

  puts "Creating User using seed..."
  user1 = User.new(
      username: "iqbal",
      email: "iqbal@gmail.com",
      password: "123456",
      is_producer: true
      )

  user1.save!

  people.each do |person|
    puts "Creating User using seed..."
    user = User.new(
      username: "#{person}",
      email: "#{person}@gmail.com",
      password: "123456",
      is_producer: random_boolean
      )
    user.save!
  end
  puts "User Seeding done!"
end
