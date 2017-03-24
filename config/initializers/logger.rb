log_file_path = Rails.root.join("log","app.log").to_s
LoggerApp = Logger.new(log_file_path)