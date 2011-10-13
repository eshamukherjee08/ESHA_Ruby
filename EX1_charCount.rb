h = Hash.new
str = "esha mukherjee"
word = str.split(//)
word.each{|b|
  if h.has_key?(b)
    h[b]=h[b]+1
  else
    h[b]=1
  end
}
h.each{|elem|
  puts "\"#{elem[0]}\" => #{elem[1]}"
}