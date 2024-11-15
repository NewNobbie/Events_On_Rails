class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  # before_action :require_admin, only: [:create]

  def index
    @events = if params[:status].present?
      Event.by_status(params[:status])
    else
      Event.all
    end

      respond_to do |format|
      format.html
      format.json { render json: @events }
    end   
  end

  def create
    @event = Event.new(event_params)
    @event.admin = current_client

    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
      EventMailer.event_created_email(current_client, @event).deliver_now
      # render json: @event, status: :created
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def show # Get events/id
    respond_to do |format|
      format.html
      format.json { render json: @event }
    end  
  end

  def edit
    def edit
      puts @event.inspect  # This will print @event data in the Rails server logs
    end
    
  end  

  def update

    if params[:event][:clear_event_date] == "1"
      @event.event_date = nil
    end  

    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
      #render json: @event, status: :ok
    else
      flash.now[:alert] = 'There was an error updating the event.'
      render :edit
      #render json: @event.errors, status: :unprocessable_entity
    end  
  end  

  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to @event, status: :see_other, notice: "Event was successfully destroyed" }
      format.json { head :no_content }
    end
  end  

  
  private

  def set_event
    @event = Event.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Event not found" }, status: :not_found
  end

  def event_params
    params.require(:event).permit(:event_name, :event_date, :description, :status, :capacity)
  end  

  def event_params_update
    params.require(:event).permit(:event_name, :event_date, :description, :status , :capacity, :clear_event_date)
  end
  
  def require_admin
    unless current_client&.admin
      redirect_to events_path, alert: 'Only Admin can to perform this action'
    end  
  end  

end  

  
  