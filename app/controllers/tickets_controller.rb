class TicketsController < ApplicationController
  before_action :set_event, only: [:index, :create]

  def index
    @tickets = @event.tickets
    render json: @tickets
  end

  def create
    @ticket = @event.tickets.new(ticket_params)
    if @ticket.save
      render json: @ticket, status: :created
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
    render json: @ticket
  end

  def destroy
    @ticket.destroy
    head :no_content
  end  

  
  private

  def set_event
    @event = Event.find(params[event:id])
  end

  
end  

  
  