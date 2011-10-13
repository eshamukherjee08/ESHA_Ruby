str = gets.chomp
reg1 = /[aeiouAEIOU]/
puts str.gsub!(reg1,"*")
