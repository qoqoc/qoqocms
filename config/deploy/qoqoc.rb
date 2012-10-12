role :web, "qoqoc.ru"   # Your HTTP server, Apache/etc
role :app, "qoqoc.ru"   # This may be the same as your `Web` server
role :db,  "qoqoc.ru", :primary => true # This is where Rails migrations will run

set :deploy_to, "/home/www/projects/#{application}"

namespace :deploy do

  desc "Start application"
  task :start, :roles => :app do
  end

  desc "Stop application"
  task :stop, :roles => :app do
  end

  desc "Restart Application"
  task :restart, :roles => :app do
  end

  desc "Restart Application"
  task :reload, :roles => :app do
  end

end
