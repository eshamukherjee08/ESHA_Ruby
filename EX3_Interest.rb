class Interest
  def initialize( &intr)
    @r = 10.00
    @intr = intr
  end
  def diff(p,t)
    intr = @intr.call p,@r,t 
    si = intr[0]
    ci = intr[1]
    d = (intr[0]-intr[1]).abs
    print "The difference in rates is : #{d} INR"
  end
end
a = Interest.new {|p,r,t| [(p*r*t)/100,(p*(((100+r)/100)**t))-p]}
a.diff(100,4)