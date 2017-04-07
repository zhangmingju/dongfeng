password = nil
case Rails.env 
when "development"
when "production"
  password = "p2d-e3as*Afa"
when "test"
else
end
Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0', namespace:"sidekiq", password: password }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0', namespace:"sidekiq", password: password }
end
