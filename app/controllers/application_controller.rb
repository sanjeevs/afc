class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Include all authentication code in controllers. These are already
  # available in all the views.
  include SessionsHelper

end
