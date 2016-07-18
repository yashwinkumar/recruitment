# Devise::Async.backend = :sidekiq
# Devise::Async.queue = :default
# Devise::Async.enabled = true

Devise::Async.setup do |config|
  config.enabled = true
  config.backend = :sidekiq
  config.queue   = :default
end

