echo "Stopping previous application, if they exists..."
rm -f tmp/pids/server.pid

echo "Installing dependencies..."
bundle exec rails db:create

bundle install --jobs 20 --retry 5

# bundle exec rails secrets:setup

echo "Starting application..."
bundle exec rails s -p 3000 -b '0.0.0.0'