Given(/^I go to "([^"]*)"?/) do |url|
  visit(url)
end

Given("I save all emails") do
  emails = 0
  i = 1
  until emails >= 500
      until i == 120
          fetch_emails(i, emails)
          i += 1
      end
      click_next_button
      emails += 120
      puts emails
      i = 1
      puts i
    end
end

def fetch_emails(i, emails)
      find(:xpath, "(//a[@class='result-title hdrlnk'])[#{i}]").click
      if Capybara.has_xpath?("//button[@class='reply-button js-only']")
        find(:xpath, "//button[@class='reply-button js-only']").click
        sleep(1)
        if Capybara.has_xpath?("//p[@class='reply-email-address']")
          # puts find(:xpath, "//p[@class='reply-email-address']//a").text
          open('RESULTS.csv', 'a') do |f|
            f << find(:xpath, "//p[@class='reply-email-address']//a").text + "\n"
          end
        end
      end
      # step %{I go to "https://newyork.craigslist.org/search/fbh?s=#{emails}"}
       step %{I go to "https://newyork.craigslist.org/search/rfh?s=#{emails}"}
      # step %{I go to "https://newyork.craigslist.org/search/lab?s=#{emails}"}
      # step %{I go to "https://newyork.craigslist.org/search/spa?s=#{emails}"}
      # step %{I go to "https://newyork.craigslist.org/search/trd?s=#{emails}"}
end

def click_next_button
    first(".next").click
    sleep(2)
end
