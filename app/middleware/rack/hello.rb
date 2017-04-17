module Rack
  class Hello
    def initialize(app)
      @app = app
    end
    def call env
      start_time = Time.now
      status, header, body = @app.call(env)
      # Rails.logger.debug "=" * 50
      # LoggerApp.info("  time to Rack::Hello #{Time.now - start_time}")
      # Rails.logger.debug "=" * 50
      [status, header, body]
    end
  end
end
# Rack::Handler::WEBrick.run Rack::Hello 