arr = ['abc','def',1234,234,'abcd','x','mnop',5,'zZzZ','abcdef']
class Array
  def hashing  
     a = Hash.new
     k = self
     l = k.size
     for i in 0...l
       if(k[i].class == Fixnum)
         s = k[i].to_s
         len = s.size
         if a.has_key?(len)
           a[len] << k[i]
           a[len] << ","
         else
           a[len] = []
           a[len] << k[i]
           a[len] << ","
         end
       else
         len = k[i].size
         if a.has_key?(len)
           a[len] << "\'"
           a[len] << k[i]
           a[len] << "\'"
           a[len] << ","
         else
           a[len] = []
           a[len] << "\'"
           a[len] << k[i]
           a[len] << "\'"
           a[len] << ","
         end
       end
     end  
     a.each{|per| print "#{per[0]} =>\[#{per[1]}\], "}
  end
end
arr.hashing