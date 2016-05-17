class UsersController < ApplicationController
  before_filter :signed_in_user, 
                only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "User created"
      redirect_to @user
    else
      render 'new'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    #@user = User.find(params[:id]) since we have correct_user filter
  end

  def update
    #@user = User.find(params[:id]) since we have correct user filter
    if @user.update_attributes(user_params)
      # Remember token gets reset when the user is saved which invalidates the session.
      sign_in @user
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit' 
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to signin_url, notice: "Wrong user #{current_user.name}, Please sign in" unless current_user?(@user)
    end
end
