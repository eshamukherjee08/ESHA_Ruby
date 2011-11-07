### eval is unsafe. 'send' can ve used instead. num1.send(operator, num2)
## Sample commit
def calculate(num1,operator,num2)
  puts num1.send(operator, num2)
end

calculate 3, :+, 2
calculate 16, :/, 4
calculate 100, :-, 85
calculate 20, :*, 5