class ClientsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]
  before_action :set_client, only: [:show, :update, :destroy]

  def index
    @clients = Client.all
    render json: @clients
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      render json: @client, status: :created
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @client
  end

  def update
    if @client.update(client_params)
      render json: @client, status: :ok
    else
      render json: @client, status: :unprocessable_entity
    end  
  end 

  def destroy
    @client.destroy
    head :no_content
  end  

  
  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:client_name, :mail)
  end 

  
end  

  
  