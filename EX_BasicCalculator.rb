def calculate(num1,operator,num2)
  puts eval "#{num1} #{operator.to_s} #{num2}"
end
calculate 3, :+, 2
calculate 16, :/, 4
calculate 100, :-, 85
calculate 20, :*, 5