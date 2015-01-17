class MyBookingsController < ApplicationController
	  before_filter :authenticate_user!
	def index
  	@bookings = ClientApi.bookings_list_for_user current_user 
  end
end
