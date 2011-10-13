h = Hash.new
arr = Array.new
str = "An apple a day keeps the doctor away"
word = str.split(/\s/)
len = word.size
for i in 0...len
  arr[i] = word[i]
end
x = len-1
print "#{str} =>"
while(x>=0)
  print " #{arr[x]}"
  x = x-1
end