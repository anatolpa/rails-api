# Change to match your CPU core count
workers ENV['PUMA_WORKERS_NUMBER'] || 2

# Min and Max threads per worker
threads 1, 6

app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/shared"

#daemonize true

# Default to production
rails_env = ENV['RAILS_ENV'] || 'production'
environment rails_env

preload_app!

# Set up socket location
bind "unix://#{shared_dir}/sockets/puma.sock"

# Logging
if rails_env == 'production'
  stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true
end

# Set master PID and state locations
pidfile "#{shared_dir}/pids/puma.pid"
state_path "#{shared_dir}/pids/puma.state"
activate_control_app

before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end