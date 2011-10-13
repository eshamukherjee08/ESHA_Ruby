def TimeAdd(t1,t2)
  reg = /^\d\d:\d\d:\d\d$/
  if(reg.match(t1) and reg.match(t2))
    Adding(t1,t2)
  else
    print "\"#{t1}\",\"#{t2}\" -> sorry wrong format entered!use (hh:mm:ss)\n"
  end
end
def Adding(t1,t2)
  reg1 = /^\d\d$/
  time1 = t1.split(":")
  time2 = t2.split(":") 
  h = (time1[0].to_i+time2[0].to_i)*3600
  m = (time1[1].to_i+time2[1].to_i)*60
  s = time1[2].to_i+time2[2].to_i
  print "(\"#{t1}\",\"#{t2}\"  ) -> "
  total_sec = h+m+s
  total = total_sec/3600
  if(total > 23)
    day = total/24
    print "#{day} day & "
    total_hours = total-(day*24)
  else
    total_hours = total
  end
  t1 = total_sec-(total*3600)
  total_min = t1/60
  total_fsec = t1-(total_min*60)
  total_hours = total_hours.to_s
  total_min = total_min.to_s
  total_fsec = total_fsec.to_s
  if(reg1.match(total_hours))
    print "#{total_hours}:"
  else
    total_hours = "0#{total_hours}"
    print "#{total_hours}:"
  end
  if(reg1.match(total_min))
    print "#{total_min}:"
  else
    total_min = "0#{total_min}"
    print "#{total_min}:"
  end
  if(reg1.match(total_fsec))
    print "#{total_fsec}\n"
  else
    total_fsec = "0#{total_fsec}"
    print "#{total_fsec}\n"
  end
end
TimeAdd("00:45:34","00:15:58") 
TimeAdd("1:23:07","22:53:46")