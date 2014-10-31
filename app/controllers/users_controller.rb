class UsersController < ApplicationController

  def index
  end

  def show
    @user = User.find(session[:user_id])
    redirect_to professional_path(user_id: @user.id) if
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = ["Your account has been created successfully"]
      redirect_to @user
    else
      flash[:error] = @user.errors.full_messages
      redirect_to 'new'
    end
  end


  def update
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end

