Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis:6379/5'}
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis:6379/5'}
end
