# Model sessions as a REST action on session resource.
class SessionsController < ApplicationController

  # Create the new signin form
  def new
  end

  # Handle the POST submit
  def create
    # Find the user
    user = User.find_by_name(params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      redirect_to user
    else
      # Render does not count as new request.
      flash.now[:error] = "Invalid name/password combination"
      render 'new'
    end
  end

  # Signing out by DELETE request.
  def destroy
  end

end
