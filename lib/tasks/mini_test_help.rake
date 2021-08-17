desc 'Learn more about running tests for app using Minitest'
task :mini_test_help do
  puts " "
  puts " "
  puts "*"*50
  puts "*"*50
  print "*"
  puts " Running minitest's for Unit Testing FriendFund *"
  puts "*"*50
  puts "*"*50
  puts " "
  puts "Not much different from running any other Minitest"
  puts " "
  puts "*"*50
  puts " "
  puts " Step 1- comment out the following lines in schema locally that throw errors when running Minitest command:"
  puts " "
  puts "    In users table:"
  puts " "
  puts "  t.index [\"email\"], name: \"index_users_on_email\", unique: true "
  puts "  t.index [\"phone_number\"], name: \"index_users_on_phone_number\", unique: true "
  puts "  t.index [\"username\"], name: \"index_users_on_username\", unique: true "
  puts " "
  puts "*"*50
  puts " "
  puts " Step 2- enter the file you wish to test in Rails + Minitest format - ex:"
  puts " "
  puts " $ rails test test/name_of_testing_directory/name_of_file_you_wish_to_test"
  puts " "

  puts " "
  puts "*"*50
  puts " "
  puts " Boom! Two simple steps and your tests should be up and running :)"
  puts " "
  puts "*"*50
  puts " "

end
