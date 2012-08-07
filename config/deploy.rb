$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'bundler/capistrano'
require 'rvm/capistrano'
set :rvm_ruby_string, 'ruby-1.9.2-p290'
set :rvm_type, :user

set :application, 'campgurus'
set :scm        , :git
set :repository , 'git@github.com:campgurus/KidNimble.git'
set :user       , 'deploy'
set :use_sudo   , false
set(:deploy_to)   {"/var/www/#{application}"}
set :ssh_options, {:forward_agent => true}

def production_prompt
  puts "\n\e[0;31m   ######################################################################"
  puts "   #\n   #       Are you REALLY sure you want to deploy to production?"
  puts "   #\n   #               Enter y/N + enter to continue\n   #"
  puts "   ######################################################################\e[0m\n"
  proceed = STDIN.gets[0..0] rescue nil
  exit unless proceed == 'y' || proceed == 'Y'
end
stage = 'production'

desc 'Run tasks in new production enviroment.'
task :production do
  production_prompt
  set  :rails_env ,'production'
  set  :branch    ,'production'
  set  :host      ,'godiva.kidnimble.com'
  role :app       ,host
  role :web       ,host
  role :db        ,host, :primary => true
end

task :staging do
  production_prompt
  stage = 'staging'
  set  :rails_env ,'staging'
  set  :branch    ,'staging'
  set  :host      ,'godiva.kidnimble.com'
  role :app       ,host
  role :web       ,host
  role :db        ,host, :primary => true
end

namespace :god do
  desc "Start the application services"
  task :restart, :roles => :app do
    run "cd #{release_path} && rvmsudo rake queue:restart_workers RAILS_ENV=production"
  end
end

namespace :deploy do
  desc 'Running migrations'
  task :migrations, :roles => :db do
    run "cd #{release_path} && bundle exec rake assets:precompile RAILS_ENV=#{rails_env}"
    run "cd #{release_path} && bundle exec rake db:migrate RAILS_ENV=#{rails_env}"
  end
end

namespace :nginx do
  desc 'Reload Nginx'
  task :reload do
    sudo '/etc/init.d/nginx reload'
  end
end

namespace :thin do
  desc 'Restart Thin'
  task :restart do
    run 'rvmsudo /etc/init.d/thin restart'
  end
end

after 'deploy'           , 'deploy:migrations'
after 'deploy:migrations', 'thin:restart'
after 'thin:restart'     , 'nginx:reload'

namespace :paperclip do
  desc "Pulls Paperclip images"
  task :pull_images, :roles => :web do 
    download "#{shared_path}/system/images", "public/system/", :via => :scp
  end

  desc "Pulls Paperclip videos"
  task :pull_videos, :roles => :web do 
    download "#{shared_path}/system/medias", "public/system", :via => :scp
  end

  desc "Pull all Paperclip attachements"
  task :pull_files, :roles => :web do
    Rake::Task['paperclip:pull_images'].invoke
    Rake::Task['paperclip:pull_videos'].invoke
  end
end

namespace :db do
  task :pull do
    config = YAML::load(File.open(File.join('config', 'database.yml')))

    dump_database_remotely(config['production'], remote_file)

    compress_backup_remotely(remote_file)

    download_backup(remote_file(:compressed), local_file(:compressed))

    inflate_backup(local_file(:compressed))

    import_database(config['development'], local_file)
    
    cleanup_remotely(remote_file(:compressed))

    cleanup_locally(local_file(:uncompressed), local_file(:compressed))
  end
  
  def remote_file(state = :uncompressed)
    File.join('/home', fetch(:user, 'rails') , filename(state))
  end
  
  def local_file(state = :uncompressed)
    "tmp/" + filename(state)
  end
  
  def filename(state)
    state == :compressed ? 'db-backup.sql.gz' : 'db-backup.sql'
  end

  def dump_database_remotely(config, file)
    run "mysqldump #{mysql_connection_string(config)} > #{file}"
  end
  
  def compress_backup_remotely(file)
    run "gzip -f #{file}"
  end
  
  def download_backup(remote_file, local_file)
    download remote_file, local_file
  end
  
  def inflate_backup(file)
    logger.debug("Inflating #{file}")
    system "gunzip -f #{file}"
  end
  
  def import_database(config, file)
    command = "mysql #{mysql_connection_string(config)} < #{file}"
    logger.debug("Importing #{file} with `#{command}`")

    system command
  end
  
  def cleanup_remotely(*files)
    files.each { |file| run "rm #{file}" }
  end
  
  def cleanup_locally(*files)
    files.each do |file|
      system "rm -f #{file}"
      logger.debug("Deleted #{file}")
    end
  end
  
  def mysql_connection_string(config)
    string = " #{config['database']}"
    string << " -h#{config['host']}" if config['host']
    string << " -u#{config['username']}" if config['username']
    string << " -p#{config['password']}" if config['password']

    string
  end
end

def load_active_record_configuration
  load 'config/environment.rb'
  ActiveRecord::Base.configurations
end

        require './config/boot'
