FROM ruby:3.1.0
WORKDIR /app
COPY ./ /app
RUN apt-get update -y && bundle install
RUN apt install npm -y
RUN npm install --global yarn