class UsersController < ApplicationController

  def index
  end

  def show
    @user = User.find(params[:id])
    @professions = @user.professionals
    if @user.pro?
      @claimed_tickets = Ticket.where(professional_id: @user.id)
    else
      @tickets = @user.tickets
    end
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

