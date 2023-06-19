FROM ruby:3.2.2-alpine as build

WORKDIR /app

COPY ./Gemfile /app/Gemfile
COPY ./Gemfile.lock /app/Gemfile.lock

RUN apk add --no-cache \
  git \
  bash \
  build-base \
  libxml2-dev \
  libxslt-dev \
  nodejs \
  tzdata \
  openssl \
  postgresql-dev 

ENV BUNDLER_VERSION='2.3.26'
RUN gem install bundler --no-document -v '2.3.26'

RUN bundle config build.nokogiri --use-system-libraries &&\
  bundle install --jobs=3 --retry=3 --without development test

FROM ruby:3.2.2-alpine

WORKDIR /app

COPY . /app

RUN apk add --no-cache \
  bash \
  postgresql-dev \
  tzdata \
  libc6-compat

COPY --from=build /usr/local/bundle/ /usr/local/bundle
