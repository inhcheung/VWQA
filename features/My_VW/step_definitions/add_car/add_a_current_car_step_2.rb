Given(/^I have successfully completed step 1 with registration (.*)$/) do |reg|
  steps %(
    Given I am on the Volkswagen Homepage
    And I login into my account
    And I will be logged into my account
    And I go to add a new car
    And I select the A car I own button
    And I add #{reg} into the registration field
    And I lookup the registration
        )
end

Then(/^I will see a summary of my car - step 1:$/) do |table|
  add_car = site.my_vw.add_current_car
  Timeout.timeout(3) { sleep 1 unless add_car.step_1_summary.visible? }
  expect(add_car.step_1_summary.present?).to be true
  table.hashes.each do |hash|
    expect(add_car.step_1_summary_reg.when_present.text).to eq(hash['Registration number'])
    expect(add_car.step_1_summary_model.when_present.text).to eq(hash['Model'])
    expect(add_car.step_1_summary_details.when_present.text).to eq(hash['Details'])
  end
end

Then(/^that my car was acquired as: (.*)$/) do |acquired_as|
  expect(site.my_vw.add_current_car.step_1_summary_acquired_as).to eq(acquired_as)
end

Then(/^that I named my car: (.*)$/) do |car_name|
  expect(site.my_vw.add_current_car.step_1_summary_car_name).to eq(car_name)
end
