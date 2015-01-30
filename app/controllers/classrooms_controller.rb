class ClassroomsController < ApplicationController
  before_action :set_classroom, only: [:show]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /classrooms
  # GET /classrooms.json
  def index
    @classrooms = ClientApi.classroom_all
  end

  # GET /classrooms/1
  # GET /classrooms/1.json
  def show
  end

  # GET /classrooms/new
  def new
    @classroom = Classroom.new
  end

  # POST /classrooms
  # POST /classrooms.json
  def create
    @classroom = Classroom.new(classroom_params)
    
    respond_to do |format|
      begin
        ClientApi.classroom_create(@classroom)
        format.html { redirect_to @classroom, notice: 'El Aula se ha creado Exitosamente.' }
      rescue 
        flash[:error]= 'El Aula ya existe o se ha detectado algun conflicto.'
        format.html { render action: 'new' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classroom
      @classroom = Classroom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def classroom_params
      params.require(:classroom).permit(:name, :description)
    end
end
