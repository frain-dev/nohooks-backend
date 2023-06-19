#!/bin/bash

bundle exec rake db:migrate
bundle exec sidekiq -e ${RAILS_ENV:-development} -C config/sidekiq.yml
