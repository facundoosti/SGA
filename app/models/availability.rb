class Availability
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_reader :from
  attr_reader :to
  attr_reader :links
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
