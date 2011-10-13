def Prime(n)
  p_num = "false"
  flag = 1
  (1..n).step(1) {|n|
    if n == 1
      p_num = "1 is not prime/composite number"
    else
      for i in 1..(n-1)
        if n%i==0
          flag=i
        end
      end
      if flag>1
        p_num = "#{n} is not prime"
      else
        p_num = "#{n} is prime"
      end
    end
    puts p_num
  }
end
Prime(20)