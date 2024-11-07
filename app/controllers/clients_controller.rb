class ClientsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  def index
    @clients = @client.All
    render json: @clients
  end

  def create
    @client = @client.new(client_params)
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

  def update
    if @client = Client.update(client_params)
      render json: @client, status: :updated
    else
      render json: @client, status: :unprocessable_entity
    end  
  end 

  def destroy
    @ticket.destroy
    head :no_content
  end  

  
  private

  def set_client
    @client = Client.find(params[client:id])
  end

  def client_params
    params.require(:client).permit(:client_name, :mail)
  end 

  
end  

  
  