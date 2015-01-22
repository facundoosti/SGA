module BookingsHelper

	def is_my_book? booking
		booking['user'].eql?(current_user.email)
	end

end
