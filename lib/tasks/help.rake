desc 'Learn more about custom tasks for this project'
task :help do
  puts " "
  puts "#{Dir["./lib/tasks/*"].count} custom rake tasks added to this project:"
  puts " "

  puts Dir["./lib/tasks/*"]
  puts " "
end
