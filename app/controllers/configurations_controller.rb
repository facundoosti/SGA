class ConfigurationsController < ApplicationController
  before_action :authenticate_user!

  # GET /availabilities
  # GET /availabilities.json
  def index  
    
  end

  def edit  
    APP_CONFIG['mailer_time'] =  params[:mailer_time]
    redirect_to configurations_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_configuration
      @configuration = Availability.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def configuration_params
      params.require(:availability).permit(:from, :to)
    end
end
