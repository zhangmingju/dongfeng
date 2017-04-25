
env_prefix = Rails.env[0,3]
redis_passwd = eval("Settings.redis." + env_prefix + ".password")
redis_url = "redis://:#{redis_passwd}@#{Settings.redis.host}:#{Settings.redis.port}/#{Settings.redis.db}"

# RedisStoreUrl = {
#   host: Settings.redis.host,
#   port: Settings.redis.port,
#   db: Settings.redis.db,
#   password: redis_passwd,
#   namespace: Settings.redis.namespace.fragement
# }

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url, namespace:Settings.redis.namespace.sidekiq }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url, namespace:Settings.redis.namespace.sidekiq}
end
