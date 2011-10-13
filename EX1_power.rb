class Array
def power(n)
  a = self
  a.each{|x|
    y = 1 
    for i in 1..n
      y = y*x
    end
    print(y," ")}
end
end
[1,2,3].power(4)