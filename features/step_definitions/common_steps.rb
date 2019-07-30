Given(/^I go to "([^"]*)"?/) do |endpoint|
  visit "https://newyork.craigslist.org/search/#{endpoint}"
end

Given(/^I save all emails of "([^"]*)"?/) do |endpoint|
  i = 1
  j = 0

  120.times do
    if i <= 120
      find(:xpath, "(//a[@class='result-title hdrlnk'])[#{i}]").click
    else
      find(:xpath, "(//a[@class='result-title hdrlnk'])[#{j}]").click
    end

    if Capybara.has_xpath?("//button[@class='reply-button js-only']")
      find(:xpath, "//button[@class='reply-button js-only']").click
      sleep(1)
      if Capybara.has_xpath?("//p[@class='reply-email-address']")
        open('RESULTS.csv', 'a') do |f|
          f << find(:xpath, "//p[@class='reply-email-address']//a").text + "\n"
        end
      end
    end
    step %{I go to "https://newyork.craigslist.org/search/#{endpoint}"}
    i += 1
    end
  end

# trd - fbh - lab - spa - rfh
#
# if i >= 120
#   j += 1
#   step %{I go to "https://newyork.craigslist.org/search/spa?s=120"}
# else
#   step %{I go to "https://newyork.craigslist.org/search/spa"}
