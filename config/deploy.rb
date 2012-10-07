$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'yaml'
require 'pathname'
require 'bundler/capistrano'
require 'capistrano_colors'

set :application, "qoqocms"

role :web, "62.76.191.249"   # Your HTTP server, Apache/etc
role :app, "62.76.191.249"   # This may be the same as your `Web` server
role :db,  "62.76.191.249", :primary => true # This is where Rails migrations will run

# -----------------------------------------------------------------------------------------------
set :stage, 'production'

default_run_options[:shell] = '/bin/bash -l'

#set :rvm_ruby_string, '1.9.3'
set :bundle_dir, ''
set :bundle_flags, '--quiet'
set :bundle_without, 'test'


set :scm, :git
set :repository,  "git@git.druzh.ru:#{application}.git"

set :user, "www"
set :use_sudo, false
set :deploy_to, "/home/www/#{application}"
set :migrate_target, :latest

set :shared_children, %w(tmp log public)
set :unicorn_cmd, "/etc/init.d/unicorn"

after "deploy:update_code", :copy_database_config, :after_update_code

namespace :deploy do
  task :default do
    update_code
    create_symlink
    migrate
    restart
    cleanup
  end

  task :finalize_update, :roles => :app, :except => {:no_release => true} do
    run "chmod -R g+w #{latest_release}" if fetch(:group_writable, true)

    run <<-CMD
      rm -rf #{latest_release}/tmp #{latest_release}/log #{latest_release}/public/system &&
      ln -s #{shared_path}/log #{latest_release}/log &&
      ln -s #{shared_path}/tmp #{latest_release}/tmp &&
      ln -s #{shared_path}/public/system #{latest_release}/public/system &&
      ln -s #{shared_path}/public/uploads #{latest_release}/public/uploads
    CMD
    #run "find #{latest_release} -depth -wholename '*/.svn*' -delete"
  end

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

task :copy_database_config, roles => :app do
  db_share = "#{shared_path}/database.yml"
  db_conf = "#{release_path}/config/database.yml"
  unless File.exist?(db_share)
    run "cp #{db_conf} #{db_share}"
  end
  run "rm -f #{db_conf} && ln -s #{db_share} #{db_conf}"

end

task :after_update_code, roles => :app do
  run "cd #{release_path} && rake tmp:create"
end
