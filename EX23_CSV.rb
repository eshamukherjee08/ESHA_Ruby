require "csv"
CSV.open("EmpData.csv","wb") do |csv|
  csv << ["John","12","Developer"]
  csv << ["Mary","13","Designer"]
  csv << ["Jack","15","Developer"]
  csv << ["Jane","17","Designer"]
end
f_store=CSV.read("EmpData.csv")
file1 = File.new("Developer1.txt","w")
File.open("Developer1.txt","w") do |file1|
  file1<<"Developers:\n"
end
file2 = File.new("Designer1.txt","w")
File.open("Designer1.txt","w") do |file2|
  file2<<"Designers:\n"
end
for i in 0..3
  t_arr = f_store[i]
  if (t_arr[2] == "Developer")
    File.open("Developer1.txt","a+") do |file1|
      file1 << "#{t_arr[0]}(EmpID : #{t_arr[1]})\n"
    end
  else
    File.open("Designer1.txt","a+") do |file2|
      file2 << "#{t_arr[0]}(EmpID : #{t_arr[1]})\n"
    end
  end
end
file_array1 = IO.readlines("Developer1.txt")
puts file_array1
file_array2 = IO.readlines("Designer1.txt")
puts file_array2
