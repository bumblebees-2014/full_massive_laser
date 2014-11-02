class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    @professions = @user.professionals
    if @user.pro?
      @claimed_tickets = Ticket.where(professional_id: @user.id)
    else
      @tickets = @user.tickets
    end
  end

  def update
    current_user.update(role: params[:user][:role])
    redirect_to '/'
  end


  def new
    @user = User.new
  end

  def create
    # auth = hash of objects returned by google
    auth = request.env["omniauth.auth"]  
    # either user is found based upon the provider (in this case google_oauth2) and uid...or...they are created using a User class method
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)  
    session[:user_id] = user.id  
    redirect_to root_url, flash[:success] => "Signed in!" 
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:provider, :uid, :name, :email, :oauthtoken, :oauth_expires_at)
  end
end

