class Str < String
  
  def initialize(value)
    @value = value
  end
  
  # Method to find sub string excluded or not.
  def exclude(sub_string)
    puts "Is substring excluded?"
    val = !@value.include?(sub_string)
  end
  
  # Method to deconcatenate entered string.
  def deconcatnating
    puts "The Deconcatenated String is:"
    val = @value.split(/\s/)
  end
  
end

puts "Enter string for performing function :"
new_value = gets.chomp               # reading main string.
a = Str.new("#{new_value}")          # creating object and initializing with main string.
puts "Enter Function name to perform:-"
puts "exclude?(\'sub string\') or deconcatnating : "
a.send(gets.chomp.to_sym)
# a.instance_eval do
#   function_name = gets.chomp      #reading function name to be executed.
#   puts eval function_name
# end
