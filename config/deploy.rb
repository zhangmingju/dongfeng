require 'mina/rails'
require 'mina/git'
require 'mina/bundler'
require 'mina/rvm'

set :application_name, 'dongfeng'
set :domain, 'bajiudongfeng.xyz'
set :deploy_to, '/home/zhang/dongfeng'
set :repository, 'https://github.com/zhangmingju/dongfeng.git'
set :branch, 'master'
set :user, 'zhang'
set :rvm_path, '/home/zhang/.rvm/bin/rvm'


# shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# set :shared_dirs, fetch(:shared_dirs, []).push('somedir')
# set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')
set :shared_dirs, fetch(:shared_dirs, []).push("log","tmp/pids","tmp/sockets")
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
  command "chmod g+rx,u+rwx #{fetch(:deploy_to)}/shared/log"

  command %[mkdir -p "#{fetch(:deploy_to)}/shared/config"]
  command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/config"]

  command %[touch "#{fetch(:deploy_to)}/shared/config/database.yml"]

  command %[touch "#{fetch(:deploy_to)}/shared/config/secrets.yml"]


  command %[touch "#{fetch(:deploy_to)}/shared/config/unicorn.rb"]


  command %[touch "#{fetch(:deploy_to)}/shared/config/unicorn_init.sh"]
  command "chmod 777 #{fetch(:deploy_to)}/shared/config/unicorn_init.sh"

  command "mkdir -p #{fetch(:deploy_to)}/shared/tmp/pids"
  command "mkdir -p #{fetch(:deploy_to)}/shared/tmp/sockets"

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
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'


    on :launch do
      in_path(fetch(:current_path)) do
        invoke :'unicorn:restart'
      end
    end
  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end


namespace :unicorn do
  set :unicorn_pid, "#{fetch(:deploy_to)}/tmp/unicorn.dongfeng.pid"
 
  desc "Start unicorn"
  task :start => :environment do
    command 'echo "-----> Start Unicorn"'
    command "cd #{fetch(:deploy_to)}/current && bundle exec unicorn_rails -D -c #{fetch(:deploy_to)}/current/config/unicorn.rb"
  end
 
  desc "Stop unicorn"
  task :stop do
    command 'echo "-----> Stop Unicorn"'
    command %{
      test -s "#{fetch(:unicorn_pid)}" && kill -QUIT `cat "#{fetch(:unicorn_pid)}"` && rm -rf "#{fetch(:unicorn_pid)}" && echo "Stop Ok" && exit 0
      echo >&2 "Not running"
    }
  end
 
  desc "Restart unicorn using 'upgrade'"
  task :restart => :environment do
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
  end
end
