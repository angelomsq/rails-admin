# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"
# Change these
server '34.222.119.141', port: 22, roles: [:web, :app, :db], primary: true

set :repo_url,        'git@github.com:angelomsq/rails-admin.git'
set :application,     'rails-admin'

# If using Digital Ocean's Ruby on Rails Marketplace framework, your username is 'rails'
set :user,            'angelo'
set :puma_threads,    [4, 16]
set :puma_workers,    0

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log,  "#{release_path}/log/puma.error.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

## Defaults:
# set :scm,           :git
set :branch,        :main
# set :format,        :pretty
# set :log_level,     :debug
set :keep_releases, 3
set :keep_assets, 3

## Linked Files & Directories (Default None):
set :linked_files, %w{.env config/database.yml config/master.key}
set :linked_dirs,  %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before 'deploy:starting', 'puma:make_dirs'
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do

      # Update this to your branch name: master, main, etc. Here it's main
      unless `git rev-parse HEAD` == `git rev-parse origin/main`
        puts "WARNING: HEAD is not the same as origin/main"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
    task :restart do
      on roles(:app), in: :sequence, wait: 5 do
        invoke 'puma:restart'
      end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  # after  :finishing,    :restart

  before "deploy:assets:precompile", "deploy:yarn_install"
  namespace :deploy do
    desc "Run rake yarn install"
    task :yarn_install do
      on roles(:web) do
        within release_path do
          execute("cd #{release_path} && yarn install --silent --no-progress --no-audit --no-optional")
        end
      end
    end
  end

end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma