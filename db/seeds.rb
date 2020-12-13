# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"
require_relative 'project_seed'
require_relative 'user_seed'
require_relative 'profile_seed'

puts 'Clearing Database...'
Job.destroy_all
Project.destroy_all
Profile.destroy_all # comment this out if you don't want to delete all your Profiles
User.destroy_all # comment this out if you don't want to delete all your Users

puts 'Clearing Database done!'

# ~~~~~~~ USER SEED ~~~~~~~

user_seed

# ~~~~~~~ PROFILE SEED ~~~~~~~

profile_seed

# ~~~~~~~ PROJECT SEED ~~~~~~~

project_seed

# ~~~~~~~ JOB SEED ~~~~~~~

job_seed
