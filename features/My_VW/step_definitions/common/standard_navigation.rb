Given(/^I am on the Volkswagen Homepage$/) do
  site.homepage.visit
end

When(/^I click the book a service button in navigation$/) do
  site.primary_nav.book_service
end

When(/^I go to add a new car$/) do
  add_car = site.my_vw.add_current_car
  sleep(1) # Allow JS to load in on page
  add_car.select_my_cars.when_present.click
  add_car.scroll_to_add_a_car
  add_car.select_add_a_car.when_present.click
end

Then(/^I will be on the dashboard$/) do
  expect(site.my_vw.current_car_dashboard.current_dashboard_section_present?).to be true
end

When(/^I select browser back button$/) do
  site.primary_nav.browser_back
end
