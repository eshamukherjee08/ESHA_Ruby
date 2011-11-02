main_code = []
read_line = gets.chomp
while(read_line != "") do
  if(read_line == "q" || read_line == "Q")
    abort
  else
    main_code << read_line
    read_line = gets.chomp
  end
end
eval "#{main_code.join(";")}"
