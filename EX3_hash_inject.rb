arr = ['abc','def',1234,234,'abcd','x','mnop',5,'zZzZ','abcdef']
class Array
  def hashing
     big = Hash.new  
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
     a.each{|per| 
      if(per[0]%2 == 0)
       if big.has_key?('even')
         big['even'] << "\["
         big['even'] << per[1]
         big['even'] << "\]"
       else
         big['even'] = []
         big['even'] << "\["
         big['even'] << per[1]
         big['even'] << "\]"
       end
      else
        if big.has_key?('odd')
           big['odd'] << "\["
           big['odd'] << per[1]
           big['odd'] << "\]"
         else
           big['odd'] = []
           big['odd'] << "\["
           big['odd'] << per[1]
           big['odd'] << "\]"
        end
      end
     }
     big.each{|p| print "#{p[0]} =>\[#{p[1]}\], "}
  end
end
arr.hashing