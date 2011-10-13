class Name
  def initialize(firstname , *args)
    begin
      if (args.size == 0 || args.size > 1)
        raise "exception_agrs"
      else
        @firstname = firstname
        lastname = args[0]
        @lastname = lastname
      end
    rescue
      abort "Handling WRONG input exception : #{$!}"
    end
  end
  def to_s
    reg = /^[A-Z]/
    begin
      if !(@firstname =~ reg)
        raise "exception_caps"
      else
        puts "FirstName : #{@firstname} \n& \nLastName : #{@lastname}"
      end
    rescue
      if $!.to_s == "exception_caps"
        puts "Handling SMALL CASE input exception : #{$!}"
      end
    end
  end
end
<<<<<<< HEAD
p1 = Name.new
p1.printt("Esha")
=======
p1 = Name.new("Esha","Mukherjee")
puts p1
>>>>>>> e6ddaa0734f79ff2f0353e4d24f493a349b58404
