class ClientApi
  class << self
    
    #Ver los recursos
    def resource link
      response = JSON.parse RestClient.get "#{link}"
      response['resource']
    end
    
    #Lista los recursos
    def classroom_all
      response = JSON.parse RestClient.get "#{APP_CONFIG['api_host']}/resources"
      response['resources']
    end

    #Crea un recurso
    def classroom_create classrooms
      response = JSON.parse RestClient.post "#{APP_CONFIG['api_host']}/resources", {name: classrooms.name, description: classrooms.description }
      response = response['resource']
      Classroom.new name:response['name'], description:response['description']
    end

    #Lista Reservas
    def bookings_list link, params=""
      response = JSON.parse RestClient.get "#{link}?#{params}"
      response['bookings']
    end 

    def approved_books
      resources = classroom_all
      links = resources.map{ |r| r['links'].first['uri']}
      bookings = []
      links.each do |link|
        bookings << bookings_list(link, 'status=approved')
      end
      bookings  
=begin   
      emails = []
      bookings.each do|book|
        if book[:start] <= APP_CONFIG[:mailer_time]
          email << book
        end 
      end
=end  
    end

    #Crea una Reserva
    def book_create link, from, to, user
      response = RestClient.post "#{link}?", {from: from , to: to, user: user}
      BookingMailer.status_change("Pendiente").deliver
    end 

    #Autoriza una Reserva
    def authorize_book links
      response = JSON.parse RestClient.put links[:uri],  {:content_type => :json}
      BookingMailer.status_change("Autorizado").deliver
    end

    #Rechaza una Reserva
    def reject_book links
      response = RestClient.delete links[:uri]
      BookingMailer.status_change("Rechazado").deliver
    end 
     
    def availabilities_list link, params=""
      response = JSON.parse RestClient.get "#{link}/availability?#{params}"

      availability =  []
      response['availability'].each do |a| 
        availability << Availability.new(from:a['from'], to:a['to'], links: a['links'])
      end
      availability
    end

  end
end