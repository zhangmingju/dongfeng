require 'mina/rails'
require 'mina/git'
require 'mina/rvm'
require 'mina/unicorn' 
require 'mina_sidekiq/tasks'

set :application_name, 'dongfeng'
set :domain, 'bajiudongfeng.xyz'
set :deploy_to, '/home/zhang/dongfeng'
set :repository, 'https://github.com/zhangmingju/dongfeng.git'
set :branch, 'master'
set :user, 'zhang'
set :rvm_path, '/home/zhang/.rvm/bin/rvm'

set :shared_dirs, fetch(:shared_dirs, []).push('tmp/sockets', 'tmp/pids','public/uploads')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml','config/unicorn.rb','config/settings.yml')

task :environment do
  invoke :'rvm:use', 'ruby-2.3.0@global'
end

task :setup do
  command %[touch "#{fetch(:deploy_to)}/shared/config/database.yml"]
  command %[touch "#{fetch(:deploy_to)}/shared/config/secrets.yml"]
  command %[touch "#{fetch(:deploy_to)}/shared/config/unicorn.rb"]
end

desc "Deploys the current version to the server."
task :deploy do
  deploy do

    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    command %[bundle install]
    # invoke :'bundle:install'
    # 第一次的时候需要创建数据库
    # invoke :'rails:db_create'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      # 注意pid路径问题
      invoke :'unicorn:restart'
      invoke :'sidekiq:restart'
    end
  end
end

task :deploy_multi do 
  puts "/home/zhang/dongfeng deploy start"
  invoke :'deploy'
  puts "/home/zhang/dongfeng deploy end"
  puts "--------**************---------"
  set :deploy_to, '/home/zhang/test'
  puts "/home/zhang/test deploy start"
  invoke :'environment'
  invoke :'deploy'
  puts "/home/zhang/test deploy end"
end

