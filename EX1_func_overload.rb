def area_overload(*args)
  if(args.size == 1)
    area = 3.14*args[0]*args[0]
    print "The area of CIRCLE is : #{area}\n"
  elsif(args.size == 2)
    area = args[0]*args[1]
    print "The area of RECTANGLE is : #{area}\n"
  elsif(args.size == 3)
    a = args[0]
    b = args[1]
    c = args[2]
    s = (a+b+c)/2
    x = (s * (s-a) * (s-b) * (s-c)).abs
    area = Math.sqrt(x).to_i
    print "The area of TRIANGLE is : #{area}\n"
  else
    print "Sorry wrong number of arguments...cant parse!\n"
  end
end
area_overload(1)
area_overload(3,4)
area_overload(5,2,8)
area_overload()