class ProfessionalsController < ApplicationController
  
  def show
  end

  def new
    @user = User.find(current_user.id)
    @professional = @user.professionals.new
  end

  def create
    @user = User.find(current_user.id)
    @professional = @user.professionals.new(professional_params)
    if @professional.save
      flash[:success] = ["You've successfully added yourself as a professional! Now start helping out!"]
      redirect_to @user
    else
      flash[:error] = ["Whoops! Something went wrong, please fill out all fields and try again"]
      redirect_to 'new'
    end
  end

  def edit
  	@user = User.find(session[:user_id])
  	@professions = @user.professionals
  end

  def update

    @user = User.find(session[:user_id])
    @professional = Professional.find(params[:id])
    if @professional.update(professional_params)
      redirect_to @user
    end
  end

  def destroy
  	user = User.find(session[:user_id])
    professional = Professional.find(params[:id])
    if professional.destroy
      flash[:success] = ["Removed a profession from your account"]
      redirect_to user
    else
      flash[:error] ["you fucked something up"]
    end
  end

  private
  def professional_params
      params.require(:professional).permit(:bio, :years_of_exp, :profession_id)
  end
end
