require 'date'

module TimeCalc
  
  # Method to parse time
  def parse_time(time)
    DateTime.strptime(time, "%H%M").to_time.utc
  end
  
  # Method to return average.
  def average(min,max)
    average = (max - min)/2
    final_value = min + average
  end
end

class AverageTime
  include TimeCalc
  
  # Method to store time values.
  def time_list(*args)
    time_value_array = []
    for i in 0...args.size
      time_value_array << parse_time(args[i])
    end
    min_max(time_value_array)
  end
  
  # Method to find minimum and maximum time values.
  def min_max(time_value_array)
    min, max = time_value_array[0], time_value_array[0]
    for i in 1...time_value_array.size
      if(time_value_array[i] > max)
        max = time_value_array[i]
      elsif(time_value_array[i] < min)
        min = time_value_array[i]
      end
    end
    puts "Average Time is:- #{ average(min,max).strftime( "%H:%M:%S" ) }"
  end
end

t = AverageTime.new
t.time_list("0300","1400","2100","2300")