class Classroom

  extend ActiveModel::Naming
  include ActiveModel::Conversion   
  
  attr_reader :name
  attr_reader :link
  attr_reader :description
  attr_reader :errors

  def initialize args=nil
    unless args.nil?
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end  
    @errors = ActiveModel::Errors.new(self)
  end  

  def persisted?
    false
  end

  def self.all
    response = JSON.parse RestClient.get 'http://localhost:9292/resources'
    classrooms =  []
    response['resources'].each {|cr| classrooms << Classroom.new(name:cr['name'], description:cr['description'], link: cr['links'].last['uri'])}
    classrooms
  end

  def self.create classrooms
     response = RestClient.post 'http://localhost:9292/resources', {name: classrooms.name, description: classrooms.description }
  end

end