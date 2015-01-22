class ClientApi
  class << self
    
    #Lista los recursos
    def classroom_all
      response = JSON.parse RestClient.get "#{APP_CONFIG['api_host']}/resources"
      response['resources']
    end

    def classroom_create classrooms
      response = JSON.parse RestClient.post "#{APP_CONFIG['api_host']}/resources", {name: classrooms.name, description: classrooms.description }
      response = response['resource']
      Classroom.new name:response['name'], description:response['description']
    end

    def bookings_list link, params=""
      response = JSON.parse RestClient.get "#{link}/bookings?#{params}"
      response['bookings']
    end 

    def book_create link, form, to
      response = RestClient.post "#{link}?", {from: from , to: to}
    end 

    def bookings_list_for_user user
      raise user.bookings.inspect
      classrooms = self.classroom_all
      response = []
      classrooms.each do |cr|    
        response << (JSON.parse RestClient.get "#{cr.link}/bookings?")
      end   
      my_bookings = []
      classrooms.each do |cr|
        my_bookings << cr["bookings"]
      end        
    end 

    def authorize_book links
      response = JSON.parse RestClient.put links[:uri],  {:content_type => :json}
    end

    def reject_book links
      response = RestClient.delete links[:uri]
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