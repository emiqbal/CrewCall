def profile_seed
  producers = User.where(is_producer: true)
  users = User.where(is_producer: false)
  url = 'https://source.unsplash.com/500x500/?face'

  producers.each do |producer|
    puts "Creating Profile for each Producer using seed..."
    pic = URI.open(url)
    profile = Profile.new(
      rich_bio: "I am #{producer.username}",
      department: "Production",
      company_name: "#{producer.username} Productions",
      first_name: "#{producer.username}",
      last_name: "A"
      )
    profile.user = producer
    profile.photo.attach(io: pic, filename: "#{producer.username}.png", content_type: 'image/png')
    profile.save!
  end

  department = %w(Camera Lighting Casting Talent AD Production Transport Location)

  users.each do |user|
    puts "Creating Profile for each User using seed..."
    pic = URI.open(url)
    profile = Profile.new(
      rich_bio: "I am #{user.username}",
      department: department.sample,
      first_name: "#{user.username}",
      last_name: "A"
      )
    profile.user = user
    profile.photo.attach(io: pic, filename: "#{user.username}.png", content_type: 'image/png')
    profile.save!
  end
  puts "Profile Seeding done!"
end
