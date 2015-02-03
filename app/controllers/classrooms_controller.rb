class ClassroomsController < ApplicationController
  before_action :authenticate_user!
  #load_and_authorize_resource

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
    @classroom={name:'', description:''}
    @action = {action: :create}
    @method=  :post 
  end

  def editar
    session[:classroom_update] = params[:link] if params[:link]  
    @classroom = ClientApi.classroom params[:link]
    @action = {action: :modificar}
    @method=  :put
  end

  # POST /classrooms
  # POST /classrooms.json
  def modificar
    respond_to do |format|
      begin
        ClientApi.classroom_update(session[:classroom_update],classroom_params)
        format.html { redirect_to classrooms_path, notice: 'El Aula ha sido modificada Exitosamente.' }
      rescue 
        @classroom= classroom_params
        @action = {action: :modificar}
        @method=  :put
        flash.now[:error]= 'El Aula ya existe o se ha detectado algun conflicto.'
        format.html { render action: 'editar' }
      end
    end
  end

  def create
    @classroom = Classroom.new(classroom_params)
    
    respond_to do |format|
      begin
        ClientApi.classroom_create(@classroom)
        format.html { redirect_to @classroom, notice: 'El Aula se ha creado Exitosamente.' }
      rescue 
        @classroom={name:'', description:''}
        @action = {action: :create}
        flash.now[:error]= 'El Aula ya existe o se ha detectado algun conflicto.'
        format.html { render action: 'new' }
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def classroom_params
      params.require(:classroom).permit(:name, :description)
    end
end
