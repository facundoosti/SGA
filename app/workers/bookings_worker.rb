 class BookingsWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely }

  def perform

 	  bookings = ClientApi.approved_books
		bookings.each do|book|
			booking_date_start = Date.parse book["start"]
			lapso = (booking_date_start - Date.today).to_i * 24
			if lapso <= APP_CONFIG["mailer_time"]
				BookingMailer.reservation_fulfillment(book[:user]).deliver
			end	
		end
	
	end	
end