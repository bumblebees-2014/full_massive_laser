class TicketsController < ApplicationController

  def complete
    @ticket = Ticket.find(params[:id])
    @ticket.update(closed: true)
    redirect_to tickets_path
  end

  def index
    redirect_to signin_path if session[:user_id] == nil
    redirect_to root_path unless current_user.pro?
    @tickets = []
    current_user.professions.each do |profession|
      @tickets.push(profession.tickets.where(closed: false).order(created_at: :desc))
    end
    @tickets.flatten!
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def create
    user = User.find(session[:user_id])
    ticket = user.tickets.create(ticket_params)
    if ticket.valid?
      flash[:success] = ["Your ticket has been created successfully!"]
      redirect_to ticket
    else
      flash[:error] = @ticket.errors.full_messages
      redirect_to new_ticket_path
    end
  end

  def new
    @ticket = Ticket.new
    @professions = Profession.all
  end

  def update
    profession_id = Ticket.find(params[:id]).profession_id
    @ticket = Ticket.find(params[:id])
    professional_id = current_user.professionals.where(profession_id: profession_id)[0].id
    if @ticket.professional_id == nil
      @ticket.update(professional_id: professional_id)
    else
      @ticket.update(professional_id: nil)
    end
    render(partial: "tickets/ticket_show")
  end

  private
  def ticket_params
    params.require(:ticket).permit(:title, :body, :profession_id, :user_id)
  end
end
