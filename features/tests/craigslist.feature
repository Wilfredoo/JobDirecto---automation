Feature: Open multiple tabs in Craigslist

    Scenario Outline: To save time I want to open all the tabs automatically
      Given I go to "<endpoint>"
      And I save all emails of "<endpoint>"

        Examples:
          |endpoint   |
          |fitness    |
          |hospitality|
          |artisan    |
          |spa        |
          |salon      |
