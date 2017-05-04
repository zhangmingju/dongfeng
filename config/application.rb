require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dongfeng
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = "zh-CN"
    config.eager_load_paths +=  %W(#{config.root}/lib)
    config.eager_load_paths << Rails.root.join('app', 'form_builders')
    config.active_job.queue_adapter = :sidekiq
    # config.middleware.insert_before "Rack::Sendfile", "MyMiddleware"
    # config.middleware.use "Rack::Hello"

    # grape
    config.paths.add File.join('app','api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]

    # jbuilder
    config.middleware.use(Rack::Config) do |env|
      env['api.tilt.root'] = Rails.root.join 'app', 'api','views'
      # env['api.tilt.root'] = Rails.root.join 'app', 'views', 'api'
    end

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
  end
end
