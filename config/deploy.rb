require 'mina/rails'
require 'mina/git'
require 'mina/bundler'
require 'mina/rvm'
require 'mina_sidekiq/tasks'
require 'mina/unicorn'

set :application_name, 'dongfeng'
# set :domain, 'bajiudongfeng.xyz'
set :domain, '139.196.124.252'
set :deploy_to, '/home/zhang/dongfeng'
set :repository, 'https://github.com/zhangmingju/dongfeng.git'
set :branch, 'master'
set :user, 'zhang'
set :rvm_path, '/home/zhang/.rvm/bin/rvm'
set :shared_paths, ['sockets','pids']
set :unicorn_pid, '/home/zhang/dongfeng/current/pids/unicorn.dongfeng.pid'



# shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
set :shared_dirs, fetch(:shared_dirs, []).push("log","pids","sockets")
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml','config/unicorn.rb','config/unicorn_init.sh')


# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  invoke :'rvm:use', 'ruby-2.3.0@global'
end
# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do

  command "mkdir -p #{fetch(:deploy_to)}/shared/log"
  command "mkdir -p #{fetch(:deploy_to)}/shared/config"
  command "mkdir -p #{fetch(:deploy_to)}/shared/pids"
  command "mkdir -p #{fetch(:deploy_to)}/shared/sockets"

  command %[touch "#{fetch(:deploy_to)}/shared/config/database.yml"]
  command %[touch "#{fetch(:deploy_to)}/shared/config/secrets.yml"]
  command %[touch "#{fetch(:deploy_to)}/shared/config/unicorn.rb"]
end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    # 第一次的时候需要创建数据库
    # invoke :'rails:db_create'
    invoke :'rails:db_migrate'
    # invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      invoke :'unicorn:restart'
      invoke :'sidekiq:restart'
    end
  end
end

