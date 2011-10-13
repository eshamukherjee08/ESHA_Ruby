def FindCount(str,find)
  arr = Array.new
  reg = Regexp.new(find,"i")
  reg1 = Regexp.new(find)
  arr = str.scan(reg)
  len = arr.size
  nstr = ""
  for i in 0...len
  match = reg.match(str)
    if match
      nstr= nstr+"#{match.pre_match}(#{match[0]})"
      str = match.post_match.dup
    elsif i == len
      nstr = nstr + str
    end
  end
  puts "The highlighted string is : #{nstr}\n"
  print "Total Occurences found: #{len}"
end
FindCount("Can you can a can as a canner can can a can?","can")