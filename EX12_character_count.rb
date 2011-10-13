str = "This string is for test counting 10 && hello *"
lc = 0
uc = 0
dig = 0
spl = 0
word = str.split(//)
word.each{|c|
  if("a".."z").include?(c)
    lc = lc+1
  elsif ("A".."Z").include?(c)
    uc = uc+1
  elsif ("0".."9").include?(c)
    dig = dig+1
  else
    spl = spl+1
  end
  }
print "Number of Upper Case : #{uc},\n"
print "Number of Lower Case : #{lc},\n"
print "Number of Digits : #{dig},\n"
print "Number of Special Characters : #{spl}"