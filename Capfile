require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/bundler"
require "capistrano/rails"
require "capistrano/rbenv"
set :rbenv_type, :user
set :rbenv_ruby, '2.7.4'


require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

require 'capistrano/puma'
install_plugin Capistrano::Puma

# Depending on your server, you may need a different plugin
# For a Digital Ocean deploy, 'Daemon' will work
# Documentation: https://github.com/seuros/capistrano-puma
# From the documentation: "If you using puma daemonized (not supported in Puma 5+)""
install_plugin Capistrano::Puma::Daemon

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
