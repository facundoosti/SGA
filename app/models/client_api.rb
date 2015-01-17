class ClientApi
  class << self
    def classroom_all
      response = JSON.parse RestClient.get "#{APP_CONFIG['api_host']}/resources"
      
      classrooms =  []
      response['resources'].each do |cr| 
        classrooms << Classroom.new(name:cr['name'], description:cr['description'], link: cr['links'].last['uri'])
      end
      classrooms
    end

    def classroom_create classrooms
      response = JSON.parse RestClient.post "#{APP_CONFIG['api_host']}/resources", {name: classrooms.name, description: classrooms.description }
      response = response['resource']
      Classroom.new name:response['name'], description:response['description']
    end

    def bookings_list link, params=""

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