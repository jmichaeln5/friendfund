desc 'Create Users (skips Devise user confirmation)'
task :create_users => :environment do


# user_count = User.last.id ||= 0

user_count = User.any? ? User.last.id : 0
  puts "*"*50
  puts " "
  puts "#{user_count} Users in DB"
  puts " "
  puts "Last User: " + (User.any? ? User.last.inspect : " no users found...")

  puts " "

  puts "*"*50
  puts " "
  puts "Creating 10 Users..."
  puts " "
  puts "*"*50
  puts " "

  starting_id_to_create = User.last ? ( User.last.id + 1) : 1
  users_to_create = 10
  ending_id_to_create = starting_id_to_create + users_to_create

  (starting_id_to_create..ending_id_to_create).each do |id|
        user = User.new(
            id: id,
            first_name: 'User',
            last_name: "#{id.humanize.capitalize}",
            # phone_number: "954"+[*0..3, *0..4].sample(7).join,
            phone_number: [*0..3, *0..3, *0..4].sample(7).join,
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

    puts "*"*50
    puts " "
    puts "Created #{users_to_create} new users."
    puts " "
    puts "*"*50
    puts " "

    ActiveRecord::Base.connection.tables.each { |t| ActiveRecord::Base.connection.reset_pk_sequence!(t) }

end
