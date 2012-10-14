role :web, "qoqoc.ru"   # Your HTTP server, Apache/etc
role :app, "qoqoc.ru"   # This may be the same as your `Web` server
role :db,  "qoqoc.ru", :primary => true # This is where Rails migrations will run

set :deploy_to, "/home/www/projects/#{application}"

set :passenger_port, "3001"
set :passenger_pid, "#{shared_path}/tmp/pids/passenger.#{passenger_port}.pid"

namespace :deploy do

  desc "Start application"
  task :start, :roles => :app do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec nohup passenger start -p #{passenger_port} &"
  end

  desc "Stop application"
  task :stop, :roles => :app do
    run "[ -f #{passenger_pid} ] && kill -QUIT `cat #{passenger_pid}`"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    stop
    sleep 5
    start
  end

end
