require 'convoy'

Convoy.ssl = true
Convoy.api_key = ENV['CONVOY_API_KEY']
Convoy.project_id = ENV['CONVOY_PROJECT_ID']
Convoy.path_version = 'v1'
