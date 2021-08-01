desc 'Help with Heroku'
task :heroku_help do

  puts " "
  puts " "
  puts "*"*50
  puts "*"*50
  print "*"*6
  print " Running terminal commands on Heroku "
  puts "*"*7
  puts "*"*50
  puts "*"*50
  puts " "
  puts "Same as any heroku command but modify according to env"
  puts " "
  puts "For example..."
  puts " "
  puts "  $ bundle "
  puts "would be "
  puts "  $ heroku run bundle --remote development"
  puts " or "
  puts " heroku run bundle --app development-friendfund"
  puts " "
  puts "more examples:"
  puts " "
  puts "  $ heroku run bundle --remote development"
  puts "  $ heroku run rails c --sandbox --remote development"
  puts "  $ heroku run rails db:migrate --remote development"

  puts " "
  puts "*"*50
  puts "*"*50
  print "*"*14
  print " Pushing to Heroku "
  puts "*"*17
  puts "*"*50
  puts "*"*50

  puts " "
  puts "Pushing to Development:"
  puts "  $ git push development development:main"
  puts " "
  puts " "
  puts "Pushing to Staging:"
  puts "  $ git push staging main"
  puts " "


  puts " "
  puts "Pushing to Production:"
  puts "  $ git push production main"


  puts " "
  puts "*"*50
  puts "*"*50
  puts "*"*50
end
