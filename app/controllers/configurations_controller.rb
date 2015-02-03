class ConfigurationsController < ApplicationController

  before_action :authenticate_user!

  def index  
  end

  def edit  
    APP_CONFIG['mailer_time'] =  configuration_params[:mailer_time].to_i
    redirect_to configurations_path, notice: "El tiempo de envio ha sido modificado correctamente."
  end

  private
    def configuration_params
      params.require(:configuration).permit(:mailer_time)
    end
end