FROM ruby:2.3.1
RUN apt-get update && apt-get -y install build-essential libpq-dev nodejs
RUN gem install bundler
RUN mkdir /foc
WORKDIR /foc
ADD Gemfile /foc/Gemfile
ADD Gemfile.lock /foc/Gemfile.lock
RUN bundle install

ADD . /foc
