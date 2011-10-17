=begin
Class Variables Used
@@date_hash : to store updated dates
@@day_hash : to store updated days.
@@close_day : to store list of closed days.
@@close_date : to store list of closed dates.
@@start_time : to store default start time.
@@end_time : to store default end time.

Variables Used
num : for converting digit to week day.
duration : duration required for meeting.
duration_req : duration in minutes.
app_date : user fed appointment date.
app_time : user fed meeting start time.
in_date : a particular date converted to day form.
val : to get values for a particular key.
starting : fetching start time for day or date.
ending : fetching end time for day or date.
flag/f : used as flag for while loop termination.
time_avail : time available for a day for meeting.
target_time : time of ending meeting if ending same day.
time_left : time left if meeting extended further.
app_date_next : next day if meeting extended.
n_day : converting date value to string.
time_value : storing time available for a given day.
final_date : final date of meeting completion.
final_date_start : start time of final_date.
time1/time2 : used for subtracting time values.
=end

require 'date'
class BusinessCenterHours
   @@date_hash,@@day_hash,@@close_day,@@close_date = Hash.new,Hash.new,Array.new,Array.new
   @@close_day << "sun"
  def initialize(start_time,end_time)
    @@start_time, @@end_time = start_time, end_time
  end
  
  def update(date_day,start_t,end_t)                           #Function to update timings on basis of day and date.
    if(/^:([a-zA-Z]{3})$/ =~ date_day)                         #check if value entered is day?
      @@day_hash[$1]=[start_t,end_t]
    else
      @@date_hash[date_day] = [start_t,end_t]
    end
  end
  
  def parser(date)                                            #function to return day of week(0-6).
    cur_day = DateTime.strptime(date, "%b %d, %Y").wday       #conversion to corresponding number.
    return cur_day
  end
  
  def closed(c_day)                                           #to maintain list of holidays.
    if(/^([a-zA-Z]{3})$/ =~ c_day)
      @@close_day << c_day                                    #if day entered as closed.
    else
      @@close_date << c_day                                   #if date entered as closed
    end
  end
  
  def num_converter(num)                                      #function to convert in day from number generated.
    case num
    when 0
      return "sun"
    when 1
      return "mon"
    when 2
      return "tue"
    when 3
      return "wed"
    when 4
      return "thu"
    when 5
      return "fri"
    when 6
      return "sat"
    else
      abort "sorry"
    end
  end
  def calculate_deadline(duration,app_date,app_time)            #function to check whether date is current or closed if yes terminates else calls schedular function.
    in_date = num_converter(parser(app_date))
    if(Date.parse(app_date) <= Date.today)
      puts "Sorry..Cannot schedule for today or past date!today is :#{Date.today}"
    else
      if(@@close_date.include?(app_date))
        print "Sorry!date Closed/Holiday."
      elsif(@@close_day.include?(in_date))
        print "Sorry!day Closed/Off."
      else
        scheduler(duration,app_date,app_time)
      end
    end
  end 
  
  def scheduler(duration,app_date,app_time)                                                                     #function to schedule meeting and provide deadline.
    duration_req, app_time, in_date = ((duration.to_i)*60), (app_time.to_i), (num_converter(parser(app_date)))  
    if(@@date_hash.include?(app_date))
      val = @@date_hash.values_at(app_date)
      starting, ending = (val[0][0].to_i), (val[0][1].to_i)
    elsif(@@day_hash.include?(in_date))
      val = @@day_hash.values_at(in_date)
      starting, ending = (val[0][0].to_i), (val[0][1].to_i)
    else
      starting, ending = (@@start_time.to_i), (@@end_time.to_i)
    end
     if(app_time>ending)
      f, app_date = 0, (Date.parse(app_date)+1).strftime("%b %d,%Y")
      while(f == 0) do
        in_date = num_converter(parser(app_date))
        if(@@close_day.include?(in_date) || @@close_date.include?(app_date))
          app_date = (Date.parse(app_date)+1).strftime("%b %d,%Y")
        else
          app_time, ending, f = get_start(app_date), get_end(app_date), 1
        end
      end
    end
    time_avail = time_diff(ending,app_time)
    if duration_req < time_avail
      if duration_req <60
        target_time = app_time+duration_req
      else
        target_time = app_time+((duration_req/60)*100)+(duration_req%60)
      end
      in_date = num_converter(parser(app_date))
      puts "Deadline: #{in_date} #{app_date}, #{target_time}" 
    else
      time_left, app_date_next, flag = duration_req-time_avail, Date.parse(app_date)+1, 0
      while(flag == 0) do 
        date = app_date_next.strftime("%b %d,%Y")
        in_date = num_converter(parser(date))
        if(@@close_day.include?(in_date) || @@close_date.include?(date))
          app_date_next = app_date_next+1
        else
          n_day = app_date_next.strftime("%b %d, %Y")
          time_value = get_s_e_time(n_day)
          time_left = (time_left-time_value)
          if(time_left > 0)
            app_date_next = app_date_next+1
          else
            final_date = app_date_next.strftime("%b %d, %Y")
            final_date_start, time_left = get_start(final_date), (time_value-time_left.abs)
            target_time, in_date = (final_date_start+((time_left.abs/60)*100)+(time_left.abs%60)), num_converter(parser(final_date))
            puts "Deadline : #{in_date},#{final_date} at #{target_time}"
            flag = 1
          end
        end
      end
    end
  end
  
  def time_diff(time1,time2)                              #function to calculate difference in time.
    if(time1.to_i>time2.to_i)
      m = ((time1/100)-(time2/100))*60-(time2%100)
    else
      m = ((time2/100)-(time1/100))*60-(time1%100)
    end
    return m
  end
  
  def get_s_e_time(app_date)                              #function to calculate working time duration for a day.
    in_date = num_converter(parser(app_date))
    if(@@date_hash.include?(app_date))
      val = @@date_hash.values_at(app_date)
      starting,ending = (val[0][0].to_i), (val[0][1].to_i)
    elsif(@@day_hash.include?(in_date))
      val = @@day_hash.values_at(in_date)
      starting,ending = (val[0][0].to_i), (val[0][1].to_i)
    else
      starting,ending = (@@start_time.to_i),(@@end_time.to_i)
    end
    time_value = time_diff(ending,starting)
    return time_value
  end                                                                                          
  
  
  def get_start(app_date)                                #function to get starting time for a day.
    in_date = num_converter(parser(app_date))
    if(@@date_hash.include?(app_date))
      val = @@date_hash.values_at(app_date)
      starting = (val[0][0].to_i)
    elsif(@@day_hash.include?(in_date))
      val = @@day_hash.values_at(in_date)
      starting = (val[0][0].to_i)
    else
      starting = (@@start_time.to_i)
    end
    return starting
  end  
  
  def get_end(app_date)                                 #function to get ending time for a day.
    in_date = num_converter(parser(app_date))
    if(@@date_hash.include?(app_date))
      val = @@date_hash.values_at(app_date)
      ending = (val[0][1].to_i)
    elsif(@@day_hash.include?(in_date))
      val = @@day_hash.values_at(in_date)
      ending = (val[0][1].to_i)
    else
      ending = (@@end_time.to_i)
    end
    return ending
  end
end
h=BusinessCenterHours.new('0900','1500')
h.update(":sat","1000","1700")
h.update("Jan 4,2011","0800","1300")
h.closed("thu")
h.closed("wed")
h.closed("Dec 25,2011")
h.calculate_deadline("7","Dec 24,2011","1845") 
h.calculate_deadline("2","Dec 30,2011","1400")
