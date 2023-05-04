FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y postgresql-client

RUN mkdir /Part-ner
WORKDIR /Part-ner

RUN apt-get install -y nodejs npm && npm install n -g && n 16.19.1
RUN npm install --global yarn

COPY Gemfile /Part-ner/Gemfile
COPY Gemfile.lock /Part-ner/Gemfile.lock

RUN bundle install
COPY . /Part-ner