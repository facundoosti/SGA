class BookingMailer < ActionMailer::Base
  default from: "sga@sga.com"

  def status_change status, booking=""
    @status = status
    mail(to: "facundoosti@gmail.com", subject: 'Cambio de Estado de la Reserva')
  end

  def reservation_fulfillment
    @start = ""
    mail(to: "facundoosti@gmail.com", subject: 'Cambio de Estado de la Reserva')
  end
end
