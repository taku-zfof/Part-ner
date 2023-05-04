FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y postgresql-client

RUN mkdir /myapp
WORKDIR /myapp

RUN apt-get install -y nodejs npm && npm install n -g && n 16.19.1
RUN npm install --global yarn

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN bundle install
COPY . /myapp