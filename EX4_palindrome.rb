str = gets.chomp
def palindromes(s)
  if (s == "q" || s == "Q")
    puts "Sorry U Chose to exit!"
  elsif (s == s.reverse)
    puts s + " is a Palindrome!"
  else
    puts s + " is not a palindrome"
  end
end
palindromes(str)