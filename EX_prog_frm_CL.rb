class Object
  def get_info
    puts "Enter method name: "
    method_name = gets.chomp
    puts "Enter single line of code: "
    line_of_code = gets.chomp
    method_name line_of_code
  end
  
  define_method(:method_name) do |line_of_code|
    eval "#{line_of_code}"
  end
end
get_info