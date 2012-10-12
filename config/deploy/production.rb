role :web, "qoqoc.ru"   # Your HTTP server, Apache/etc
role :app, "qoqoc.ru"   # This may be the same as your `Web` server
role :db,  "qoqoc.ru", :primary => true # This is where Rails migrations will run

set :deploy_to, "/home/www/#{application}"

set :unicorn_cmd, "/etc/init.d/unicorn"

namespace :deploy do

  desc "Start application"
  task :start, :roles => :app do
    try_sudo unicorn_cmd + " start"
  end

  desc "Stop application"
  task :stop, :roles => :app do
    #run "[ -f #{unicorn_pid} ] && kill -QUIT `cat #{unicorn_pid}`"
    try_sudo unicorn_cmd + " stop"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    #run "[ -f #{unicorn_pid} ] && kill -USR2 `cat #{unicorn_pid}` || #{unicorn_start_cmd}"
    stop
    sleep 5
    start
    #try_sudo unicorn_cmd + " restart"
  end

  desc "Restart Application"
  task :reload, :roles => :app do
    #run "[ -f #{unicorn_pid} ] && kill -USR2 `cat #{unicorn_pid}` || #{unicorn_start_cmd}"
    #try_sudo unicorn_cmd + " reload"
  end

end
