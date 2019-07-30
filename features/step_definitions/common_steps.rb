Given(/^I go to "([^"]*)"?/) do |url|
  visit(url)
end

Given("I save all emails") do
  i = 1
  j = 0

  240.times do
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
    i += 1
    if i >= 120
      j += 1
      step %{I go to "https://newyork.craigslist.org/search/spa?s=120"}
    else
      step %{I go to "https://newyork.craigslist.org/search/spa"}
    end
  end
end

# trd - fbh - lab - spa - rfh
