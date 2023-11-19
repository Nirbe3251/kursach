FROM ruby:3.1.0
WORKDIR /app
COPY ./instatalk /app
RUN apt-get update -y && bundle install
RUN apt install npm -y
RUN npm install --global yarn && npm install 
# RUN yarn run
RUN bundle add cssbundling-rails
RUN rails css:install:bootstrap