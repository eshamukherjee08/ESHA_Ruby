class Vehicle
  attr_accessor :price       #to make price changable overtime.
  attr_reader :name           #to make name readable.
  def initialize(name, price)  #function to initialize variables.
    @name = name
    @price = price
  end 
  def to_s                     #function to show content.
    puts "Name_of_Vehicle: #{@name}, Price : #{@price}"
  end
end
class Bike < Vehicle            #sub class Bike of Vehicle.
  def initialize(name, price, dealer)
    @name = name
    @price = price
    @dealer = dealer
  end 
  def to_s                       #to show content
    super
    puts "Dealer : #{@dealer}"
  end
end
b1 = Bike.new("Suzuki", 60000, "Suzuki Showroom")
puts b1
b1.price = 65000
puts b1
  