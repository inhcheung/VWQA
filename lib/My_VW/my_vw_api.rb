require 'rest-client'

class MyVWAPI < MyVW
  def initialize
    headers = {
      :content_type => 'application/json',
      :accept => 'application/json',
      :'x-access-username' => 'test_client',
      :'x-access-password' => 'Manuela1999'
    }

    @user_api = RestClient::Resource.new("https://#{get_sb_host}/api/user/2.0", headers: headers, verify_ssl: false)
    @auth_api = RestClient::Resource.new("https://#{get_sb_host}/api/auth/2.0", headers: headers, verify_ssl: false)
  end

  # Returns the service bridge host based on hostname for API related stuff.
  def get_sb_host
    if ENV['HOST'].match(/(vw)([0-9]+)/)
      env = ENV['HOST'].match(/(vw)([0-9]+)/)
      return "10.69.1#{env[2]}.103"
    elsif ENV['HOST'].match(/([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+)/)
      env = ENV['HOST'].match(/([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+)/)
      return "#{env[1]}.#{env[2]}.#{env[3]}.103"
    else
      return nil
    end
  end

  def get_login_token(user, password)
    data = {
      username: user,
      password: password
    }.to_json
    login = @auth_api['/login'].post(data)
    # STDOUT.puts login.response
    JSON.parse(login)['access_token']
  end

  def get_user_details(uuid, access_token)
    auth_header = { Authorization: "Bearer #{access_token}" }
    JSON.parse(@user_api["/users/#{uuid}"].get auth_header)
  end

  def update_user_details(uuid, access_token, options = {})
    auth_header = { Authorization: "Bearer #{access_token}" }
    retailer = options[:retailer_id] || nil
    house_number = options[:houseNumber] || nil
    street = options[:street] || nil
    street2 = options[:street2] || nil
    city = options[:city] || nil
    county = options[:county] || nil
    postcode = options[:postcode] || nil

    user_data = {
      retailerId: retailer,
      details: {
        houseNumber: house_number,
        street: street,
        street2: street2,
        city: city,
        county: county,
        postcode: postcode
      }
    }.to_json
    @user_api["/users/#{uuid}"].put user_data, auth_header
  end

  def get_users_current_cars(uuid, access_token)
    auth_header = { Authorization: "Bearer #{access_token}" }
    JSON.parse(@user_api["/users/#{uuid}/cars"].get auth_header)
  end

  def remove_current_car(uuid, access_token, car_id)
    auth_header = { Authorization: "Bearer #{access_token}" }
    @user_api["/users/#{uuid}/cars/#{car_id}"].delete auth_header
  end

  def add_new_current_car(uuid, access_token, options = {})
    display_name = options[:display_name] || 'My Car'
    car_status = options[:car_status] || 'CURRENT'
    registration = options[:registration] || 'YG61YRO'
    model = options[:model] || 'Golf'
    derivative = options[:derivative] || 'GOLF GTI'
    registration_date = options[:registration_date] || '2014-02-12'
    fuel_type = options[:fuel_type] || 'Petrol'
    vin = options[:vin] || 'WVWZZZ13ZCV003370'
    year = options[:year] || '2014'
    engine_capacity = options[:engine_capacity] || '1.2'
    transmission = options[:transmission] || 'Manual'
    purchase_type = options[:purchase_type] || 'NEW_CAR'

    car_data = {
      displayName: display_name,
      carStatus: car_status,
      carDetails: {
        registrationNumber: registration,
        model: model,
        derivative: derivative,
        registrationDate: registration_date,
        fuelType: fuel_type,
        vin: vin,
        year: year,
        engineCapacity: engine_capacity,
        transmission: transmission
      },
      suppliedByRetailer: '00153',
      servicedByRetailer: '00153',
      purchaseType: purchase_type
    }.to_json

    auth_header = { Authorization: "Bearer #{access_token}" }
    @user_api["/users/#{uuid}/cars"].post car_data, auth_header
  end

  def add_new_ordered_car(uuid, access_token, order_number)
    car_data = {
      orderNumber: order_number,
      displayName: 'ORDER_CAR_TEST'
    }.to_json

    auth_header = { Authorization: "Bearer #{access_token}" }
    begin
      @user_api["/users/#{uuid}/cars/order"].post car_data, auth_header
    rescue RestClient::Exception => e
      STDOUT.puts e.response
    end
  end
end
