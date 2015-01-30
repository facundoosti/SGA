 class BookingsWorker
  include Sidekiq::Worker

  def perform()
  	bookings = Client.approved_books
		emails = []
		bookings.each do|book|
			if book[:start] <= APP_CONFIG[:mailer_time]
				email << book
			end	
		end
	end	
end