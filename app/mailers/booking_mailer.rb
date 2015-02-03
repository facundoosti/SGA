class BookingMailer < ActionMailer::Base
  default from: "sga@sga.com"

  def status_change status, user
    @status = status
    mail(to: user, subject: 'Cambio de Estado de la Reserva')
  end

  def reservation_fulfillment user
    mail(to: user, subject: 'Cumplimiento de Reserva')
  end
end
