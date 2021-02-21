#!/bin/bash

echo "Installing dependencies from Gemfile"
bundle install
echo "Creating development database"
bundle exec rails db:create
echo "Migrating development database"
bundle exec rails db:migrate
echo "Preparing test database"
bundle exec rails db:test:prepare

echo "post-create script is done. Your development environment is ready!"