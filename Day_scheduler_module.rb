### GENERAL COMMENTS - In case of holidays schedule meeting the next working day
#### Use Time/Date/DateTime for time manipulations and calculations throughout 
=begin
Class Variables Used
@close_day : to store updated dates
@update_date_hash : to store updated days.
@close_day : to store list of closed days.
@close_date : to store list of closed dates.

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
module Usable
  
  # function to  day of week(0-6).
  def parser(date)                                            
    #### COMMENT - Should be written as - DateTime.strptime(date, "%b %d, %Y").wday directly, no need for variable
    DateTime.strptime(date, "%b %d, %Y").wday       #conversion to corresponding number.
  end
  
  # function to convert in day from number generated.
  def num_converter(num)                                      
    case num
    when 0 then :sun
    when 1 then :mon
    when 2 then :tue
    when 3 then :wed
    when 4 then :thu
    when 5 then :fri
    when 6 then :sat
    else abort "sorry"
    end
  end
  
  #### COMMENT - Use Time/Date/DateTime for time manipulations and calculations
  def time_diff(time1,time2)              #function to calculate difference in time. 
    (time1 > time2) ? ((time1-time2)/60) : ((time2-time1)/60)
  end
  
  def parse_time(time)
    DateTime.strptime(time, "%H%M").to_time.utc
  end
  
  def next_date(date)
    (Date.parse(date) + 1).strftime("%b %d,%Y")
  end
end

class BusinessCenterHours 
  include Usable
 
   attr_accessor :start_time, :end_time
   def initialize(start_time,end_time)
    #### Make start_time and end_time attribute accessors
      @start_time, @end_time = parse_time(start_time), parse_time(end_time)
      @update_date_hash, @update_day_hash, @close_day, @close_date = {},{},[],[]
      @close_day << :sun
   end
  
  
   #Function to update timings on basis of day and date.
  def update(date_day,start_t,end_t)      
    #### COMMENT  - Should be written as - date_day.is_a?(Symbol)
    start_t, end_t = parse_time(start_t), parse_time(end_t)
    (date_day.is_a?(Symbol)) ? 
    (@update_day_hash[date_day] = [start_t,end_t]) : 
    (@update_date_hash[date_day] = [start_t,end_t])
    #### date_day.is_a?(Symbol) ? (@update_day_hash[$1] = [start_t,end_t]) : (@update_date_hash[date_day] = [start_t,end_t])    #check if value entered is day? 
  end
  
  
  #to maintain list of holidays.
  def closed(c_day)                                           
    ### COMMENT  - Should be written as - date_day.is_a?(Symbol)
    ### (/^([a-zA-Z]{3})$/ =~ c_day) ? 
    ### Can be written as -
    ### (/^([a-zA-Z]{3})$/ =~ c_day) ? (@close_day << c_day) : (@close_date << c_day)
    
    c_day.is_a?(Symbol) ? (@close_day << c_day) : (@close_date << c_day)
  end
 
 
  #function to check whether date is current or closed if yes terminates else calls schedular function.
  def calculate_deadline(duration, app_date, app_time)   
             
    app_time_client, app_date_client, app_time = app_time.dup, app_date.dup, parse_time(app_time)
    (Date.parse(app_date) <= Date.today) ? scheduler(duration, next_date(app_date), app_time) : scheduler(duration, app_date, app_time)  
  end 
  
 
  def scheduler(duration, app_date, app_time)
    
    duration_req, in_date = duration*60, (num_converter(parser(app_date)))  
    # p in_date => :sat
    
    if(@update_date_hash.include?(app_date))
      val = @update_date_hash.values_at(app_date)
      starting, ending = val[0][0], val[0][1]
    elsif(@update_day_hash.include?(in_date))
      val = @update_day_hash.values_at(in_date)
      starting, ending = (val[0][0]), (val[0][1])
    else
      starting, ending = @start_time, @end_time
    end
    
   ## if the meeting the after working hours - finds the next available working day  
   if(app_time > ending)
     flag, app_date = true, next_date(app_date)
     while(flag) do
       next_day_closed?(num_converter(parser(app_date)), app_date) ? 
       (app_date = next_date(app_date)) : (app_time, ending, flag = get_start(app_date), get_end(app_date), false)
     end
   end
    
    time_avail = time_diff(ending, app_time).to_i
    
    if duration_req < time_avail
      puts "Deadline:  #{num_converter(parser(app_date))}, #{app_date}, #{(app_time + duration_req * 60).strftime("%H:%M:%S")}"

    else
      time_left, app_date_next, flag = duration_req - time_avail, Date.parse(app_date) + 1, true
      while(flag) do 
        date = app_date_next.strftime("%b %d,%Y")
        in_date = num_converter(parser(date))
        
        if next_day_closed?(in_date, date)
          app_date_next = app_date_next + 1
        else
          time_value = get_s_e_time(app_date_next.strftime("%b %d, %Y"))
          time_left -= time_value
          if time_left > 0
            app_date_next = app_date_next + 1
          else
             final_date = app_date_next.strftime("%b %d, %Y")
             final_date_start, time_left = get_start(final_date), ((time_value-time_left.abs).to_i)*60
             target_time, in_date = final_date_start+time_left, num_converter(parser(final_date))
             puts "Deadline : #{in_date},#{final_date} at #{target_time.strftime("%H:%M:%S")}"
             flag = false
          end
        end
      end
    end
  end
  
  def next_day_closed?(day, date)
    @close_date.include?(day) || @close_date.include?(date)
  end
  
  
  # function to calculate working time duration for a day.
  def get_s_e_time(app_date)                             
    in_date = num_converter(parser(app_date))
    
    if(@update_date_hash.include?(app_date))
      val = @update_date_hash.values_at(app_date)
      starting,ending = (val[0][0]), (val[0][1])
    elsif(@update_day_hash.include?(in_date))
      val = @update_day_hash.values_at(in_date)
      starting,ending = (val[0][0]), (val[0][1])
    else
      starting,ending = (@start_time),(@end_time)
    end
    
    time_diff(ending,starting)
  end                                                                                          
  
  
  def get_start(app_date)                                #function to get starting time for a day.
    in_date = num_converter(parser(app_date))

    if(@update_date_hash.include?(app_date))
      @update_date_hash.values_at(app_date)[0][0]
    elsif(@update_day_hash.include?(in_date))
      @update_day_hash.values_at(in_date)[0][0]
    else
      @start_time
    end
  end  
  
  def get_end(app_date)                                 #function to get ending time for a day.
    in_date = num_converter(parser(app_date))

    if(@update_date_hash.include?(app_date))
      @update_date_hash.values_at(app_date)[0][1]
    elsif(@update_day_hash.include?(in_date))
      @update_day_hash.values_at(in_date)[0][1]
    else
      @end_time
    end
  end
  
end

h = BusinessCenterHours.new('0900','1500')

h.update(:sat,"1000","1700")
h.update("Jan 4,2011","0800","1300")
h.closed(:thu)
h.closed(:wed)
h.closed("Dec 25,2011")
h.calculate_deadline(7,"Dec 24,2011","1845")         #scheduling after time.
h.calculate_deadline(2,"Dec 30,2011","1400")         #scheduling normal date.
# h.calculate_deadline(1,"Dec 25,2011","1600")         #scheduling for holiday/closed date.
# h.calculate_deadline(2,"Oct 18,2011","1600")        #scheduling for past date