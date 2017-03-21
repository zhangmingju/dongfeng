log_file_path = Rails.root.join("log","app.log").to_s
logger = Logger.new(log_file_path)