class Partition
  
  def input(part, *args)
    list_numbers, sum = [], 0
    
    for i in 0...args.size
      list_numbers << args[i]
    end
    
    list_num_input, list_numbers, sum = list_numbers, list_numbers.sort.reverse, sum_array(list_numbers)
    (sum % part == 0) ? (partition(list_numbers, part, sum)) : (abort "Sorry! cannot perform partitioning.")
  end
  
  def partition(list_numbers, part, sum)
    list_numbers.each{ |num|
      if (num > (sum/part)) 
        abort "**Sorry! cannot perform partitioning."
      end
      }
    partition_hash = {}
    (1..part).each {|key|
      if !(partition_hash.has_key?(key))
        partition_hash[key] = []
      end
      partition_hash[key] = [list_numbers[0]]
      list_numbers.shift
      }
  
    for i in 1..part
      while(sum_array(partition_hash[i]) < (sum/part) and list_numbers != nil) do
        partition_hash[i] << list_numbers[0]
        list_numbers.shift 
      end
    end
    partition_hash.each{|key,value| puts "#{key}: #{value}"}
  end
  
  def sum_array(array)
    sum = 0
    array.each{|i| sum += i}
    return sum
  end
end

a = Partition.new
# a.input(3,3,3,3,2,2,2,2,2,2,2,2,2)               #Test case 1
a.input(2,9,12,14,17,23,32,34,40,42,49)

#a.input(3,3,3,3,2,2,2,2,2,2,2,2,2)               #Test case 1
#a.input(2,2,3,1,1,1)                            #Test case 2
#a.input(9,1,1,1,1,1,1,1,1,1)                     # Test case 3
a.input(2,9,12,14,17,23,32,34,40,42,49)