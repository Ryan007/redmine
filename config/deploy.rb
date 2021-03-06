require 'rvm/capistrano'
require 'bundler/capistrano'

set :rails_env, 'production'
set :rvm_type, :system
set :rvm_ruby_string, 'ruby-1.9.3-p448@rails3.2.13_redmine'
set :rvm_path, '/home/ryan/.rvm'
set :rvm_bin_path, "#{rvm_path}/bin"
set :rvm_lib_path, "#{rvm_path}/lib"
set :deploy_via, :remote_cache


set :bundle_cmd, "/home/ryan/.rvm/gems/ruby-1.9.3-p448@global/bin/bundle"
set :passenger_cmd,  "#{bundle_cmd} exec /home/ryan/.rvm/gems/ruby-1.9.3-p448@rails3.2.13_redmine/bin/passenger"

set :normalize_asset_timestamps, false


set :application, "red.17jianya.com"
set :repository,  "git@github.com:Ryan007/redmine.git"

set :scm, :git

role :web, "red.17jianya.com"                          # Your HTTP server, Apache/etc
role :app, "red.17jianya.com"                          # This may be the same as your `Web` server
role :db,  "red.17jianya.com", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"
# set :port, 22229
set :use_sudo, false
set :user, "ryan"    # 上传了ssh的public key
set :web_user, "www-data"
#set :password, "passwd"
default_run_options[:pty] = true


set :branch, "master"
set :deploy_to, "/home/ryan/www/redmine/red.17jianya.com/htdocs/#{application}"


set :keep_releases, 1

# 正式环境的配置
task :symlink_database_yml do
  # run "rm #{release_path}/config/database.yml"
  # run "ln -sfn #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  # run "ln -sfn #{shared_path}/config/environments/production.rb #{release_path}/config/environments/production.rb"
  # run "ln -sfn #{shared_path}/public/uploads/tmp #{release_path}/public/uploads/tmp"
end

after "bundle:install", "symlink_database_yml"
after "deploy:migrate", "deploy:cleanup" 

namespace :deploy do
#   task :stop, :roles => :web, :except => { :no_release => true } do
#     run "cd #{current_path} && #{passenger_cmd} stop"
#     run "rm /tmp/crm.*"
#   end

#   task :start, :roles => :web, :except => { :no_release => true } do 
#     run "cd #{current_path} && #{passenger_cmd} start --socket /tmp/redmine.junyfly.net.socket -d -e production --pid-file /tmp/xmcrm.pid"
#   end
#   task :restart, :roles => :web, :except => { :no_release => true } do
#     # run "cd #{current_path} && #{passenger_cmd} stop"
#     # run "rm /tmp/crm.*"
#     # run "cd #{current_path} && #{passenger_cmd} start --socket /tmp/redmine.junyfly.net.socket -d -e production --pid-file /tmp/xmcrm.pid"
#   end
end



# 常用的任务
# $ cap deploy:setup
# $ cap deploy
# $ cap deploy:cleanup
# $ cap deploy:migrate
# $ cap deploy:migrations