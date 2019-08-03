Given(/^I go to "([^"]*)"?/) do |endpoint|
  visit "https://newyork.craigslist.org/search/jjj?query=#{endpoint}"
end

Given(/^I save all emails of "([^"]*)"?/) do |endpoint|
  i = 1

  120.times do
    find(:xpath, "(//a[@class='result-title hdrlnk'])[#{i}]").click

    if Capybara.has_xpath?("//button[@class='reply-button js-only']")
      find(:xpath, "//button[@class='reply-button js-only']").click
      sleep(1)
      if Capybara.has_xpath?("//p[@class='reply-email-address']")
        open('RESULTS.csv', 'a') do |f|
          f << find(:xpath, "//p[@class='reply-email-address']//a").text + "\n"
        end
      end
    end
    step %{I go to "#{endpoint}"}
    i += 1
    end
  end
