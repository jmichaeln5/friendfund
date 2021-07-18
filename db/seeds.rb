# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.all.count < 1
  admin_user = User.create!(
      id: 1,
      first_name: 'Admin',
      last_name: "User",
      phone_number: "954"+[*0..3, *0..4].sample(7).join,
      email: "admin@gmail.com",
      username: "adminuser",
      password: '123456',
      password_confirmation: "123456"
  ).skip_confirmation!
  admin_user.save

  # puts "*"*50
  # puts "Creating Users..."
  # puts "*"*50
  # puts "adminuser created."
  # puts "*"*20
  #
  # (2..5).each do |id|
  #     user = User.create!(
  #         id: id,
  #         first_name: 'User',
  #         last_name: "#{id.humanize.capitalize}",
  #         phone_number: "954"+[*0..3, *0..4].sample(7).join,
  #         email: "user#{id}@gmail.com",
  #         username: "user#{id.humanize}",
  #         password: '123456',
  #         password_confirmation: "123456"
  #     )
  #     user.skip_confirmation!
  #     user.save
  #     puts "#{user.username} created."
  #     puts "*"*20
  # end
end

# if User.all.count < 5
  # puts "*"*50
  # puts "Creating Users..."
  # puts "*"*50
  # puts "adminuser created."
  # puts "*"*20
  #
  # (2..5).each do |id|
  #     user = User.create!(
  #         id: id,
  #         first_name: 'User',
  #         last_name: "#{id.humanize.capitalize}",
  #         phone_number: "954"+[*0..3, *0..4].sample(7).join,
  #         email: "user#{id}@gmail.com",
  #         username: "user#{id.humanize}",
  #         password: '123456',
  #         password_confirmation: "123456"
  #     )
  #     user.skip_confirmation!
  #     user.save
  #     puts "#{user.username} created."
  #     puts "*"*20
  # end
# end



ActiveRecord::Base.connection.tables.each { |t| ActiveRecord::Base.connection.reset_pk_sequence!(t) }
