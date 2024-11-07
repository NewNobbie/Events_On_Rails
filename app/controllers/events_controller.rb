class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  def index
    @events = Event.all
    render json: @events
  end

  def create
    @event = @event.new(event_params)
    if @event.save
      render json: @event, status: :created
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def show # Get events/id
    render json: @event
  end

  def update
    if @event.update(event_params)
      render json: @event, status: :updated
    else
      render json: @event.errors, status: :unprocessable_entity
    end  
  end  

  def destroy
    @event.destroy
    head :no_content
  end  

  
  private

  def set_event
    @event = Event.find(params[event:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Event not found" }, status: :not_found
  end

  def event_params
    params.require(:event).permit(:event_name, :event_date, :description, :status, :capacity)
  end  

  
end  

  
  