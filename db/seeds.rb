# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if  ( User.any? == (false || nil) ) || ( (User.all.count < 1) && (User.all.count < 5) )
# if (User.all.count < 1) && (User.all.count < 5)
  admin_user = User.new(
      id: 1,
      first_name: 'Admin',
      last_name: "User",
      phone_number: "954"+[*0..3, *0..4].sample(7).join,
      email: "admin@gmail.com",
      username: "adminuser",
      password: '123456',
      password_confirmation: "123456"
  )
  admin_user.skip_confirmation!
  admin_user.save

  sample_user = User.new(
      id: 2,
      first_name: 'Timmy',
      last_name: "Tables",
      phone_number: "954"+[*0..3, *0..4].sample(7).join,
      email: "timmytables@gmail.com",
      username: "timmyt",
      password: '123456',
      password_confirmation: "123456"
  )
  sample_user.skip_confirmation!
  sample_user.save

  puts " "
  puts " "
  puts "*"*50
  puts "*"*50
  puts " "
  puts "Creating Users..."
  puts " "
  puts "*"*50
  puts "*"*50
  puts " "
  puts " "
  puts "*"*20
  puts "#{admin_user.username} created."
  puts "*"*20
  puts "#{admin_user.inspect}"
  puts "*"*20
  puts " "
  puts "*"*20
  puts "#{sample_user.username} created."
  puts "*"*20
  puts "#{sample_user.inspect}"
  puts "*"*20
  puts " "

  (3..5).each do |id|
      user = User.new(
          id: id,
          first_name: 'User',
          last_name: "#{id.humanize.capitalize}",
          phone_number: "305"+[*0..3, *0..4].sample(7).join,
          email: "user#{id}@gmail.com",
          username: "user#{id.humanize}",
          password: '123456',
          password_confirmation: "123456"
      )
      user.skip_confirmation!
      user.save
      puts "*"*20
      puts "#{user.username} created."
      puts "*"*20
      puts "#{user.inspect}"
      puts "*"*20
      puts " "

  end
end

ActiveRecord::Base.connection.tables.each { |t| ActiveRecord::Base.connection.reset_pk_sequence!(t) }
