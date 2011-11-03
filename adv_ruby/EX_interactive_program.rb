main_code = []
read_line = gets.chomp
while !(read_line.empty?) do
  # read_line.upcase != 'Q'
  if(read_line.upcase == 'Q')
    exit ## use exit
  else
    main_code << read_line
    read_line = gets.chomp
  end
end
eval "#{main_code.join(";")}"
