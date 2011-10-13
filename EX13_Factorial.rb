def fact(n)
  (1...n).each{|x| n=n*x}
  puts n
end
fact(5)