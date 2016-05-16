include ApplicationHelper

def sign_in(user, options={})
  visit signin_path
  fill_in "Name", with: user.name
  fill_in "Password", with: user.password
  click_button "Sign in"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end
