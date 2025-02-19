require "test_helper"
require "tmpdir"

CHROMEDRIVER_URL = "http://localhost:9515/"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

  Capybara.register_driver :selenium_remote_chrome do |app|
    
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--start-maximized')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--disable-gpu')
    options.add_argument('--headless') # Optional: Run in headless mode
    options.add_argument("--user-data-dir=#{Dir.mktmpdir}") # Creates a unique temp directory for each test


    Capybara::Selenium::Driver.new(
      app,
      browser: :remote,
      url: CHROMEDRIVER_URL,
      options: options
     
    )
  end

  Capybara.configure do |config|
    # Match what's set for URL options in test.rb so we
    # can test mailers that contain links.
    config.server_host = 'localhost'
    config.server_port = '3000'
  end

  driven_by :selenium_remote_chrome
end
