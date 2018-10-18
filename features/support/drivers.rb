selenium_hub_addr = ENV.fetch('SELENIUM_HUB_ADDR', 'selenium_hub')
selenium_hub_port = ENV.fetch('SELENIUM_HUB_PORT', '4444')
selenium_url = "http://#{selenium_hub_addr}:#{selenium_hub_port}/wd/hub"

Capybara.register_driver :selenium_grid do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.new
  capabilities.browser_name = ENV.fetch('BROWSER', 'firefox')
  capabilities.platform = ENV.fetch('PLATFORM', :any)
  capabilities.javascript_enabled = true
  capabilities.takes_screenshot = true
  capabilities['ie.ensureCleanSession'] = true

  driver_options = {
    browser: :remote,
    url: selenium_url,
    desired_capabilities: capabilities,
  }
  Capybara::Selenium::Driver.new app, driver_options
end

Capybara.default_driver = :selenium_grid