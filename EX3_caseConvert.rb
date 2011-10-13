class Convert
  def initialize(str)
    @str = str
  end
  def to_s
    str = @str
    str.each_byte{|b|
      if (b >= 65 and b <= 90)
        b = b+32
      else
        b = b-32
      end
    print b.chr
    }
  end
end
s1 = Convert.new("ABCdef")
s1.to_s
