# module SoufangUtil
#   class << self
#     def init_page
#       require 'rubygems'
#       require 'headless'
#       require 'selenium-webdriver'

#       headless = Headless.new
#       headless.start
#       driver = Selenium::WebDriver.for :chrome
#       # driver = Selenium::WebDriver.for :firefox
#       driver.navigate.to 'https://www.baidu.com'
#       puts  driver.title
#       # AppLog.info("  driver.title:  #{driver.title} ")

#       headless.destroy
#     end
#   end
# end

# # require 'rubygems'
# # require 'headless'
# # require 'selenium-webdriver'
# Headless.ly do 
#   driver = Selenium::WebDriver.for :chrome
#   driver.navigate.to 'https://www.baidu.com'
# end
# Headless.ly do 
#   driver = Selenium::WebDriver.for :firefox
#   driver.navigate.to 'https://www.baidu.com'
#   puts  driver.title
# end

# Headless.ly do 
#   driver = Selenium::WebDriver.for :firefox
# end