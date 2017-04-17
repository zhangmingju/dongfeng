class MyMiddleware
  def initialize app
    @app = app
  end
  def call env
    start_time = Time.now
    status, header, body = @app.call(env)
    # binding.pry
    # Rails.logger.debug "=" * 50
    # LoggerApp.info("  time to Rack::MyMiddle #{Time.now - start_time}")
    # Rails.logger.debug "=" * 50
    LoggerApp.info(" *****************  rack:request: #{Rack::Request.new(env).inspect}")
    [status, header, body]
  end
end