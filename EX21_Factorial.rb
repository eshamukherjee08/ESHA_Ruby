def factorial(n)
  catch(:negetive) do
    if n < 0
      puts "Exception Occurred: Cannot find factorial of NEGETIVE NUMBER!"
      throw :negetive
    else
      (2..n-1).each{|i| n*=i}
      print "The Factorial is: #{n}"
    end
  end
end
factorial(5)

 