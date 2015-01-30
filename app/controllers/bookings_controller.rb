class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /bookings
  # GET /bookings.json
  def index 
    session[:link_to_bookings] = params[:classroom][:links].last[:uri] if (params[:classroom])   
    @link = session[:link_to_bookings]
    @params= "date=#{params[:date]}&limit=#{params[:limit]}&status=#{params[:status]}"
    @bookings = ClientApi.bookings_list @link, @params
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @from = params[:from]
    @to = params[:to]
    @link = params[:links].first[:link]
  end

  # GET /bookings/1/edit
  def edit
  end

  def authorize
    links = params[:booking][:links].find{|book| book[:rel].eql? 'accept' }
    links[:method]='PUT'
    begin
      response = ClientApi.authorize_book links
      redirect_to bookings_path, notice: 'La Reserva ha sido aprobada.'
    rescue
      flash[:error]= 'La Reserva ya existe o se ha detectado algun conflicto.'
      redirect_to bookings_path
    end  
  end

  def reject
    links = params[:booking][:links].find{|book| book[:rel].eql? 'reject' }
    links[:method]='DELETE'
    begin  
      response = ClientApi.reject_book links
      redirect_to bookings_path, notice: 'La Reserva ha sido rechazada.'
    rescue
      flash[:error]= 'La Reserva ya existe o se ha detectado algun conflicto.'
      redirect_to bookings_path
    end
  end

  # POST /bookings
  # POST /bookings.json
  def create
    if params[:daterange].present?
      daterange = params[:daterange].split(' - ')
      from =  daterange.first.rstrip
      to =  daterange.last.lstrip
      
      begin 
        ClientApi.book_create params[:link], from, to, current_user.email 
        redirect_to availabilities_path, notice: 'La Reserva ha sido creada correctamente'
      rescue
        flash[:error]= 'La Reserva ya existe o se ha detectado algun conflicto.'
        redirect_to availabilities_path
      end  
    else
      redirect_to :root
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params[:booking]
    end
end
