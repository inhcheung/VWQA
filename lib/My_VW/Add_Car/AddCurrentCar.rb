require 'json'
class AddCurrentCar < MyVW
  def visit
    visit_page(page_url)
  end

  def scroll_to_bottom
    if @browser.divs(class: 'my-cars-delete-confirm').size > 5
      scroll_to(:bottom)
    end
  end

  def select_my_cars
    @browser.element(class: 'welcome-stripe__body').element(class: 'welcome-stripe__menu-list', index: 1)
  end

  def select_add_a_car
    @browser.link(text: 'Add a car')
  end

  def loading_wheel
    @browser.div(id: 'page').div(class: 'my-loading-shield')
  end

  def success_message
    @browser.element(id: 'car-detail-text')
  end

  def searched_car_reg
    success_message.li(index: 0).span(index: 1)
  end

  def searched_car_model
    success_message.li(index: 1).span(index: 1)
  end

  def searched_car_detail
    success_message.li(index: 2).span(index: 1)
  end

  def car_age_new
    @browser.radio(id: 'car-age-new')
  end

  def car_age_used
    @browser.radio(id: 'car-age-used')
  end

  def edit_car_form
    @browser.element(id: 'car-detail-edit')
  end

  def add_a_car_choices
    @browser.element(id: 'add-car-main')
  end

  def car_i_own_radio
    @browser.radio(id: 'car-status-own')
  end

  def car_i_ordered_radio
    @browser.radio(id: 'car-status-ordered')
  end

  def car_i_configured_radio
    @browser.radio(id: 'car-status-configured')
  end

  def add_a_car_options(options)
    missing_option = []
    case options
    when /A car I own/
      missing_option << 'A car I own' unless car_i_own_radio.exists?
    when /A car I ordered/
      missing_option << 'A car I ordered' unless car_i_ordered_radio.exists?
    when /A configured car/
      missing_option << 'A configured car' unless car_i_configured_radio.exists?
    end
    missing_option
  end

  def reg_lookup_button
    @browser.element(id: 'button-regLookup-submit')
  end

  def error_message
    @browser.div(class: 'error-label')
  end

  def page_url
    '/owners/my/cars/add'
  end

  def fuel_type_petrol_radio
    @browser.radio(id: 'fuel-petrol')
  end

  def fuel_type_diesel_radio
    @browser.radio(id: 'fuel-diesel')
  end

  def fuel_type_hybrid_radio
    @browser.radio(id: 'fuel-hybrid')
  end

  def fuel_type_electric_radio
    @browser.radio(id: 'fuel-electric')
  end

  def fuel_type_petrol
    @browser.elements(class: 'radio__buttons')[1].element(text: 'Petrol')
  end

  def fuel_type_diesel
    @browser.elements(class: 'radio__buttons')[1].element(text: 'Diesel')
  end

  def fuel_type_hybrid
    @browser.elements(class: 'radio__buttons')[1].element(text: 'Hybrid')
  end

  def fuel_type_electric
    @browser.elements(class: 'radio__buttons')[1].element(text: 'Electric')
  end

  def transmission_manual_radio
    @browser.radio(id: 'transmission-manual')
  end

  def transmission_automatic_radio
    @browser.radio(id: 'transmission-automatic')
  end

  def transmission_manual
    @browser.elements(class: 'radio__buttons')[2].element(text: 'Manual')
  end

  def transmission_automatic
    @browser.elements(class: 'radio__buttons')[2].element(text: 'Automatic')
  end

  def step_2_summary
    @browser.element(id: 'section-2-text')
  end

  def step_2_retailer_name
    step_2_summary.li(class: 'summaryName')
  end

  def step_2_retailer_telephone
    step_2_summary.li(class: 'summaryPhone')
  end

  def step_2_retailer_email
    step_2_summary.li(class: 'summaryEmail')
  end

  def step_1_summary
    @browser.element(class: 'my-car-form__text')
  end

  def step_1_summary_reg
    step_1_summary.li(index: 0).span(index: 1)
  end

  def step_1_summary_model
    step_1_summary.li(index: 1).span(index: 1)
  end

  def step_1_summary_details
    step_1_summary.li(index: 2).span(index: 1)
  end

  def step_1_summary_acquired_as
    step_1_summary.li(index: 3).text.match(/\:(.*)[a-zA-Z0-9]/).to_s.delete(':').strip
  end

  def step_1_summary_car_name
    step_1_summary.li(index: 4).text.match(/\:(.*)[a-zA-Z0-9]/).to_s.delete(':').strip
  end

  def car_i_own_button
    @browser.div(id: 'car-status-select').label(for: 'car-status-own')
  end

  def car_i_ordered_button
    @browser.div(id: 'car-status-select').label(for: 'car-status-ordered')
  end

  def car_configured_button
    @browser.div(id: 'car-status-select').label(for: 'car-status-configured')
  end

  def max_car_limit
    @browser.element(id: 'no-more-cars-dialog')
  end

  def max_car_limit_button
    @browser.button(class: 'my-vw-button my-vw-button--blue my-overlay__no-more-cars-button')
  end

  def registration_text_field
    @browser.text_field(id: 'registration-number')
  end

  def edit_my_car_details
    @browser.div(id: 'car-detail-toggle')
  end

  def details_registration_number
    @browser.element(id: 'details-registration-number')
  end

  def car_form_fields_empty(field)
    fields = []
    case field
    when /Model/
      fields << 'Model field contains ' + model_field.value unless model_field.value.empty?
    when /Trim/
      fields << 'Trim field contains ' + derivative_field.value unless derivative_field.value.empty?
    when /Date of registration/
      fields << 'Date of registration day field contains ' + date_registered_day.value unless date_registered_day.value.empty?
      fields << 'Date of registration month field contains ' + date_registered_month.value unless date_registered_month.value.empty?
      fields << 'Date of registration year field contains ' + date_registered_year.value unless date_registered_year.value.empty?
    when /Year of manufacture/
      fields << 'Year of manufacture field contains ' + year_manufacture.value unless year_manufacture.value.empty?
    when /Engine size/
      fields << 'Engine size field contains ' + engine_size_field.value unless engine_size_field.value.empty?
    when /I'd like to call my car/
      fields << "I'd like to call my car field contains " + my_car_name_field.value unless my_car_name_field.value.empty?
    end
    fields
  end

  def car_form_options(radios)
    options = []
    case radios
    when /Fuel type /
      options << 'Fuel type Petrol is set' if fuel_type_petrol_radio.set?
      options << 'Fuel type Diesel is set' if fuel_type_diesel_radio.set?
      options << 'Fuel type Hybrid is set' if fuel_type_hybrid_radio.set?
      options << 'Fuel type Electric is set' if fuel_type_electric_radio.set?
    when /Transmission/
      options << 'Transmission type Manual is set' if transmission_manual_radio.set?
      options << 'Transmission type Automatic is set' if transmission_automatic_radio.set?
    end
    options
  end

  def model_field
    @browser.text_field(id: 'details-model')
  end

  def derivative_field
    @browser.text_field(id: 'details-derivative')
  end

  def year_manufacture_options(year)
    return false if year.empty?
    @browser.button(class: 'ui-button my-selectbox__button ui-combobox-button').when_present.click
    @browser.li(text: year).click
  end

  def year_manufacture
    @browser.element(class: 'my-selectbox__input')
  end

  def date_registered_day
    @browser.element(id: 'details-registrationDate_day')
  end

  def clear_date_picker_field(field_object)
    field_object.when_present.send_keys(:backspace) until field_object.value.empty?
  end

  def clear_date_registered_day
    clear_date_picker_field(date_registered_day)
  end

  def date_registered_month
    @browser.element(id: 'details-registrationDate_month')
  end

  def clear_date_registered_month
    clear_date_picker_field(date_registered_month)
  end

  def date_registered_year
    @browser.element(id: 'details-registrationDate_year')
  end

  def clear_date_registered_year
    clear_date_picker_field(date_registered_year)
  end

  def my_car_name_field
    @browser.text_field(id: 'car-name')
  end

  def car_name_validation_message
    @browser.element(xpath: "//*[@id='car-details-step-1']/div[4]/div/div/div/p")
  end

  def my_car_details_errors
    @browser.element(id: 'car-detail-edit-error-sum')
  end

  def go_to_section_2
    @browser.element(id: 'goto-section-2')
  end

  def go_to_section_3
    @browser.element(id: 'goto-section-3')
  end

  def continue_to_next_step
    @browser.element(class: 'my-vw-button', text: /Continue/)
  end

  def change_step_1
    @browser.button(id: 'change-section-1')
  end

  def change_step_2
    @browser.button(id: 'change-section-2')
  end

  def retailer_location_search
    @browser.text_field(id: 'retailer-location-search')
  end

  def retailer_name_search
    @browser.text_field(id: 'retailer-name-search')
  end

  def engine_size_field
    @browser.text_field(id: 'details-engineCapacity')
  end

  def reg_input
    @browser.input(id: 'registration-number')
  end

  def preselected_retailer
    @browser.element(class: 'radio__list')
  end

  def preselected_retailer_radio
    preselected_retailer.radio(index: 0)
  end

  def back_button
    @browser.element(id: 'my-go-back-button')
  end

  def leave_overlay
    @browser.element(id: 'leaving-dialog')
  end

  def leave_overlay_title
    leave_overlay.element(class: 'my-overlay__title')
  end

  def cancel_back_button
    leave_overlay.element(class: 'my-overlay__cancel-button')
  end

  def confirm_back_button
    leave_overlay.element(id: 'leaving-dialog-confirm')
  end

  def date_picker
    @browser.element(id: 'registrationDate-datepicker-trigger')
  end

  def date_picker_years
    @browser.element(class: 'datepicker-years')
  end

  def date_picker_current_year_range
    date_picker_years.element(class: 'datepicker-switch')
  end

  def go_back_to_year_range(range)
    date_picker_years.element(class: 'chevron', index: 0).when_present.click until date_picker_current_year_range.text == range
  end

  def check_years_range
    years = []
    12.times { |i| years << date_picker_years.span(class: 'year', index: i).text }
    years
  end

  def year_of_registration(year)
    date_picker_years.span(class: 'year', text: year)
  end

  def date_picker_month
    @browser.element(class: 'datepicker-months')
  end

  def date_picker_current_year
    date_picker_month.element(class: 'datepicker-switch')
  end

  def check_months_range
    months = []
    12.times { |i| months << date_picker_month.span(class: 'month', index: i).text }
    months
  end

  def month_of_registration(month)
    date_picker_month.span(class: 'month', text: month)
  end

  def date_picker_days
    @browser.element(class: 'datepicker-days')
  end

  def date_picker_current_month
    date_picker_days.element(class: 'datepicker-switch')
  end

  def check_month_days_range
    days = []
    31.times do |i|
      begin
        days << date_picker_days.td(class: /^day$/, index: i).text
      rescue Watir::Exception::UnknownObjectException
        next
      end
    end
    days
  end

  def day_of_registration(day)
    date_picker_days.td(class: /^day$/, text: day)
  end

  def label_for_field(field)
    @browser.element(id: 'section-3-edit').div(class: 'my-input', text: /#{field}/).text
  end

  def owner_address_field_values(field, value)
    field_values = []
    value = '' if value == 'empty'
    case field
    when 'Postcode'
      field_values << 'Postcode contains ' + owner_postcode.value + ' expected ' + value unless owner_postcode.value == value
    when 'House Name / no'
      field_values << 'House Name contains ' + owner_house_number.value + ' expected ' + value unless owner_house_number.value == value
    when 'Address 1'
      field_values << 'Address 1 contains ' + owner_address_1.value + ' expected ' + value unless owner_address_1.value == value
    when 'Address 2'
      field_values << 'Address 2 contains ' + owner_address_2.value + ' expected ' + value unless owner_address_2.value == value
    when 'Town / City'
      field_values << 'City contains ' + owner_city.value + ' expected ' + value unless owner_city.value == value
    when 'County'
      field_values << 'County contains ' + owner_county.value + ' expected ' + value unless owner_county.value == value
    end
    field_values
  end

  def owner_postcode
    @browser.text_field(id: 'owner-postcode')
  end

  def owner_house_number
    @browser.text_field(id: 'owner-houseNumber')
  end

  def owner_address_1
    @browser.text_field(id: 'owner-address1')
  end

  def owner_address_2
    @browser.text_field(id: 'owner-address2')
  end

  def owner_city
    @browser.text_field(id: 'owner-city')
  end

  def owner_county
    @browser.text_field(id: 'owner-county')
  end

  def owner_postcode_lookup
    @browser.element(class: 'postcode-lookup-submit')
  end

  def owner_address_error_feedback
    @browser.element(id: 'owner-edit-error-sum')
  end

  def step_3_finish_button
    @browser.button(id: 'submit-sections-123')
  end
end
