class Class
  def carryover_attr(*args)
    args.each do |element|
      self.instance_eval do
        define_singleton_method (element) do
          if(instance_variable_get("@#{element}"))
            instance_variable_get("@#{element}")
          else
            if(self.superclass.to_s != "Object")
              self.superclass.send(element)
            end
          end
        end

        define_singleton_method("#{element}=") do |val|
          if val.class == Array
            if(instance_variable_set("@#{element}",val))
              instance_variable_set("@#{element}",val)
            else
              if(self.superclass.to_s != "Object")
                self.superclass.send(element)
              end
            end
          end
          instance_variable_set("@#{element}",val)
        end
      end
    end
  end
end


class A
  carryover_attr :a, :b
end

class B < A
  
end 

A.b = 1988 
p A.b 
p B.b
puts "------------------"
B.b = "hi"
p B.b
p A.b
puts "++++++++++++++++++"
A.b = 123
p A.b
p B.b
puts "***************"
A.a = [1,2,3,4]
p A.a
p B.a
puts "-----------------"
B.a = [8]
p A.a
p B.a
puts "________________"
B.a << 5
p B.a
p A.a
puts "----------------"
A.a << 0
p A.a
p B.a
