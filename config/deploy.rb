# $:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'yaml'
require 'pathname'
require 'bundler/capistrano'
require 'capistrano_colors'

set :application, "stantz20"

# -----------------------------------------------------------------------------------------------
set :stages, %w(production qoqoc)
set :default_stage, "production"
require 'capistrano/ext/multistage'

default_run_options[:shell] = '/bin/bash -l'

#set :rvm_ruby_string, '1.9.3'
set :bundle_dir, ''
set :bundle_flags, '--quiet'
set :bundle_without, 'test'

set :scm, :git
set :repository,  "git://github.com/qoqoc/qoqocms.git"

set :user, "www"
set :use_sudo, false
set :migrate_target, :latest
set :rails_env, :production

set :shared_children, %w(tmp log public)

after "deploy:update_code", :copy_database_config, :after_update_code

before 'deploy:finalize_update', 'set_current_release'
task :set_current_release, :roles => :app do
    set :current_release, latest_release
end

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
      rm -rf #{latest_release}/tmp #{latest_release}/log #{latest_release}/public/system #{latest_release}/db/production.sqlite3 &&
      ln -s #{shared_path}/log #{latest_release}/log &&
      ln -s #{shared_path}/tmp #{latest_release}/tmp &&
      ln -s #{shared_path}/public/system #{latest_release}/public/system &&
      ln -s #{shared_path}/public/uploads #{latest_release}/public/uploads &&
      ln -s #{shared_path}/production.sqlite3 #{latest_release}/db/production.sqlite3
    CMD
    #run "find #{latest_release} -depth -wholename '*/.svn*' -delete"
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
  run "cd #{release_path} && rvm use 1.9.3 do bundle exec rake tmp:create"
end
