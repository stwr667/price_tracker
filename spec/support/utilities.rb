
include ApplicationHelper

def valid_signin(user)
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def sign_in(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end

def fill_in_valid_signup()
  fill_in "Name",         with: "Example User"
  fill_in "Email",        with: "user@example.com"
  fill_in "Password",     with: "foobar"
  fill_in "Confirm Password", with: "foobar"
end

def perform_valid_edit(new_name, new_email, user)
  fill_in "Name",         with: new_name
  fill_in "Email",        with: new_email
  fill_in "Password",     with: user.password
  fill_in "Confirm Password", with: user.password
  click_button "Save changes"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-success', text: message)
  end
end

def fill_in_valid_product()
  fill_in "Name",         with: "Samsung Galaxy Nexus"
  fill_in "Model",        with: "I9250"
  fill_in "Description",  with: "Android 4.1 Smartphone, pure google"
  fill_in "Price",        with: "359"
  fill_in "Delivery",     with: "19.95"
  fill_in "Url",          with: "http://www.kogan.com/au/buy/samsung-galaxy-nexus"
  fill_in "Deal Expiry",  with: ""
end
