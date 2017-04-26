redis_passwd = eval("Settings.redis.#{Rails.env[0,3]}.password")
redis_url = "redis://:#{redis_passwd}@#{Settings.redis.host}:#{Settings.redis.port}/#{Settings.redis.db}"

$redis = Redis.new(:host=>Settings.redis.host,:port=>Settings.redis.port,:db=>Settings.redis.db,:password=>redis_passwd)

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url, namespace:Settings.redis.namespace.sidekiq }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url, namespace:Settings.redis.namespace.sidekiq}
end
