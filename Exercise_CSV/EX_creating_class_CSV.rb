puts "Enter name of csv file you want to read: "
file_read = gets.chomp

module Functioning
  
  # Method to read file and create objects dynamically.
  def reading_file
    file_name, counter, array_object, array_data, array_function = "#{Class_var}.csv", 0, [], [], []
    File.open(file_name, "r") do |infile|
      while (line = infile.gets)
        if(counter == 0)
          array_function, counter = line.chomp.split(/,/), 1 
        else
          array_object << self.class.new("#{line}".chomp)
          array_data << line
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
          puts @variable.split(/,/)[index]
        end
      end  
    end
  end

end

# Creating class with file name
Class_var = Object.const_set(file_read, Class.new{
  include Functioning
  def initialize (*args)
    instance_variable_set("@variable",args[0])
  end 
})
   


arr = Class_var.new.reading_file
arr[0].name
arr[0].age
arr[0].city
arr[1].name
arr[1].age
arr[1].city
        