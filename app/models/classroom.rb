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

end