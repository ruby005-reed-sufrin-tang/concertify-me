class RequestsController < ApplicationController

  SEARCH = [:artist,:city,:state]


  def index 

  end

  def new
    @request = Request.new


  end

  def create

    # binding.pry
    @request = Request.create(search_params)

    redirect_to request_url(@request)

  end


  def show
    request = Request.find(params[:id])
    # binding.pry

    @results = request.api_call 



  end 

  private

  def search_params

    params.require(:request).permit(SEARCH)

  end


end
