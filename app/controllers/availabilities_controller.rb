class AvailabilitiesController < ApplicationController
  before_action :authenticate_user!

  # GET /availabilities
  # GET /availabilities.json
  def index
    session[:link_to_availabilities] = params[:classroom][:links].first[:uri] if (params[:classroom])   
    @link = session[:link_to_availabilities]  
    session[:classroom_name] =  params[:classroom][:name] if params[:classroom]
    @classroom = session[:classroom_name]
    @params= "date=#{params[:date]}&limit=#{params[:limit]}"
    @availabilities = ClientApi.availabilities_list @link, @params
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_availability
      @availability = Availability.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def availability_params
      params.require(:availability).permit(:from, :to)
    end
end
