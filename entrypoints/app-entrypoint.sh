#!/bin/bash
set -e
npm install
# yarn run
# bundle add cssbundling-rails
# rails css:install:bootstrap
if [ -s /app/tmp/pids/server.pid ]
    then
        rm /app/tmp/pids/server.pid
fi
bundle install
rake db:migrate
exec "$@"