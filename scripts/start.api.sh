#!/bin/bash 

bundle exec rake db:migrate
bundle exec rails server -u puma -b ::
