Given(/^I go to "([^"]*)"?/) do |url|
  visit(url)
end

Given("I save all emails") do
  i = 1

  120.times do
    find(:xpath, "(//a[@class='result-title hdrlnk'])[#{i}]").click
    if Capybara.has_xpath?("//button[@class='reply-button js-only']")
      find(:xpath, "//button[@class='reply-button js-only']").click
      sleep(1)
      if Capybara.has_xpath?("//p[@class='reply-email-address']")
        puts find(:xpath, "//p[@class='reply-email-address']//a").text
      end
    end
    step %{I go to "https://newyork.craigslist.org/search/fbh"}
    i += 1
  end
end
