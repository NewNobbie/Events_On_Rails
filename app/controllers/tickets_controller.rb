class TicketsController < ApplicationController
  before_action :set_event, only: [:index, :create]

  def index
    @tickets = @event.tickets
    render json: @tickets
  end

  def create
    @ticket = @event.tickets.new(ticket_params)
    if @ticket.save
      render json: { ticket: @ticket, available_seats: available_seats }, status: :created
    else
      render json: { errors: @ticket.errors, available_seats: available_seats }, status: :unprocessable_entity
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
    render json: @ticket
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    head :no_content
  end  

  
  private

  def set_event
    @event = Event.find(params[event:id])
    rescue Active::RecordNotFound
      render json: { error: "Event not found" }, status: :not_found
  end

  def ticket_params
    params.require(:ticket).permit(:client_id, :event_id, :seat)
  end  

  # Show available seats
  def available_seats
    @event.capacity - @event.tickets.count
  end  
  
end  

  
  