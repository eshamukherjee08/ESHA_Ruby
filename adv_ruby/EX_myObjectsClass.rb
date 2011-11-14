
module MyObjectStore
  
  @@array_objects = []
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  def save
    ### COMMENT - Can be written like this-
    self.methods.include?(:validate) & !validate ? (puts "Sorry! Objects of this class are not validated.") : (@@array_objects << self)
  end               

  module ClassMethods
    
    def dynamic_function_creator(x,args)
      p self 
      self.instance_eval %{
        def find_by_#{x} param
          array_objects = MyObjectStore.class_variable_get(:@@array_objects)
          array_objects.each do |obj|
            if(obj.class == self)
              if(obj.#{x} == param[0])
                puts "Value exists in class"
              end
            end
          end
        end
        find_by_#{x} #{args}
      }
    end
    
  
    def method_missing(m, *args, &block)
      array_objects, object_enumerator = MyObjectStore.class_variable_get(:@@array_objects), []
      if (m.match(/^find_by/))
        var = "#{m}".split(/_/)[2]
        dynamic_function_creator(var,args)
      elsif array_objects.respond_to?(m)
        #### COMMENT - can be written like this
        #array_objects.collect { |obj| obj.class == self}.send(m, *args, &block)
        p array_objects.select{|obj| obj.class == self}.send(m, *args, &block)
      else
        super
      end                                             
      
    end
  end
end
 

class Play
  include MyObjectStore
  
  attr_accessor :age, :fname, :email
    
  def validate
    true
  end
  
  #### COMMENT - Put this in module, You have no control over the class which includes the method. All your functionality should go in the module.
end

p2 = Play.new
p2.age = "14"
p2.fname = "someya"
p2.email = "xyz@gfh" 
p2.save 
p3 = Play.new
p3.age = "22"
p3.fname = "esha"
p3.email = "xyz@gfh"
p3.save      
Play.find_by_age("20")
Play.find_by_fname("someya")
Play.collect{|x| x.fname}
Play.count
#Play.first
#Play.to_a 