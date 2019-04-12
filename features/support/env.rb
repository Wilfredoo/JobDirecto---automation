require 'selenium-webdriver'
require 'capybara'
require 'capybara/poltergeist'
require 'capybara/cucumber'

$browser = ENV['browser'] ||:chrome
$browser = $browser.to_sym

$driver = ENV['driver'] || :selenium
$driver = $driver.to_sym

puts "Driver: #{$driver}"
puts "Browser: #{$browser}"

# For browser Firefox, geckodriver is required: https://github.com/mozilla/geckodriver/releases
# echo $PATH
# cd into geckodriver directory (probably Downloads) and extract from zip/tar
# mv geckodriver /usr/local/bin/ (or whatever your $PATH is)
# Run Firefox with:
# cucumber /dir/some.feature driver=selenium browser=firefox

Capybara.default_driver = $driver

Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => $browser,)
end

Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, {js_errors: false, phantomjs_options: ['--ssl-protocol=auto']})
    $platform = 'poltergeist'
end

# Please note: this is not BrowserStack, just setting
# Chrome to use the 'mobile' views
Capybara.configure do |config|
    {
      # Apple
      i4: 'iPhone 4',
      i5: 'iPhone 5',
      i6: 'iPhone 6',
      i6plus: 'iPhone 6 Plus',
      ipad: 'iPad',
      ipadpro: 'iPad Pro',
      ipadmini: 'iPad Mini',

      # Samsung
      gs5: 'Galaxy S5',

      # Google
      gn7: 'Nexus 7'
    }.each do |driver_name, device_name|
        Capybara.register_driver driver_name do |app|
            mobile_emulation = { 'deviceName' => device_name }
            $platform = driver_name
            capabilities = Selenium::WebDriver::Remote::Capabilities.chrome('chromeOptions' => { 'mobileEmulation' => mobile_emulation })
            Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
        end
    end
end
