#### COMMENT - use variable for naming the class, not constant
#### COMMENT - Create instance variables names from first row, and their values from subsequent rows

# puts "Enter name of csv file you want to read: "
file_read = "Persons"

module Functioning
  
  # Method to read file and create objects dynamically.
  def reading_file
    file_name, counter, array_object, array_function = "#{Class_var}.csv", true, [], []
    File.open(file_name, "r") do |infile|
      while (line = infile.gets)
        if(counter)
          array_function, counter = line.chomp.split(/,/), false
        else
          array_object << self.class.new("#{line}".chomp, array_function)
        end
      end
    end                                           
    creating_methods(array_function)
    array_object
  end
  
  # Method to create functions dynamically.
  def creating_methods(array_function)
    array_function.each_with_index do |element, index|
      Class_var.class_eval do  
        define_method("#{element}") do
          puts instance_variable_get("@#{element}")
        end
      end  
    end
  end

end


# Creating class with file name
Class_var = Object.const_set(file_read, Class.new{
  include Functioning 
  def initialize (*args)
    if !(args.empty?)
      for i in 0..args.length 
        self.class.send(:attr_accessor, args[1][i])
        instance_variable_set("@#{args[1][i]}",args[0].split(/,/)[i]) 
      end
    end
  end     
  
  # def self.fill_data
  #    
  #  end
  #p @array_function 
})
   


arr = Class_var.new.reading_file
arr[0].name
arr[0].age
arr[0].city
arr[1].name
arr[1].age
arr[1].city           