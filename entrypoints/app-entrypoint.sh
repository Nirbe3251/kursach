#!/bin/bash
set -e
npm install
# yarn run
# bundle add cssbundling-rails
# rails css:install:bootstrap
bundle install
rake db:migrate
exec "$@"