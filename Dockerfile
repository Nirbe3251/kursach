FROM ruby:3.1.0
WORKDIR /app
COPY ./ /app
RUN apt-get update -y 
RUN apt install npm -y
RUN npm install --global yarn
RUN bundle config set --local path '/app/vendor' && bundle install && gem install rails -v 7.0.1 && gem install foreman