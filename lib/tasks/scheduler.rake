desc "This task is called by the Heroku scheduler add-on"
task :send_morning => :environment do
  SendEmail.send_scheduled("Morning")
  puts "done."
end

task :send_evening => :environment do
  SendEmail.send_scheduled("Evening")
  puts "done."
end
