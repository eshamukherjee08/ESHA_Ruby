def fibonacci(n)
  a,b=0,1
  while a<=n
    yield a
    a,b=b,a+b
  end
end
fibonacci(1000) {|a| puts a}
