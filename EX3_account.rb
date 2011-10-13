class Customer
  attr_accessor :account_no, :balance
  attr_reader :name
  @@account_no = 0
  def initialize(name)
    @name = name
    @@account_no +=1 
    @balance = 1000
    @acc_num = @@account_no
  end
  def to_s
    puts "Name: #{@name}, A/C_no: #{@acc_num}, Balance:#{@balance}"
  end
  def deposit(acc_num,amount)
    @acc_num = acc_num
    @amount = amount
    @balance = balance
    @balance = @balance + @amount
    puts "A/C no.: #{@acc_num} your new balance is: #{@balance}"
  end 
  def withdrawl(acc_num,amount)
    @acc_num = acc_num
    @amount = amount
    @balance = balance
    @balance = @balance - @amount
    puts "A/C no.: #{@acc_num} your new balance is: #{@balance}"
  end
end
p1 = Customer.new("ABC")
puts p1
p2 = Customer.new("XYZ")
puts p2
puts p2.deposit(2,500)
puts p1.withdrawl(1,500)
puts p2.deposit(2,500)


  