module MyModule
  
  def self.included(base)
    def base.chained_aliasing(old_method, new_method)
      old = old_method
      if !(old_method.to_s.split(//).pop.match(/^[a-zA-Z0-9]/))
        new_method = ("#{new_method.to_s}" + "#{old_method.to_s.split(//).pop}").to_sym
        old_method = ("#{old_method.to_s.chop}").to_sym
      end
      self.class_eval do
        alias_method "#{old_method.to_s}_without_#{new_method.to_s}".to_sym, "#{old}"
        alias_method "#{old}", "#{old_method.to_s}_with_#{new_method.to_s}".to_sym
      end
      if !(self.private_instance_methods(false).empty?)
        private "#{old}".to_sym, "#{old_method.to_s}_with_#{new_method.to_s}".to_sym
      end
    end
  end
  
end
   
class Hello

  def greet?(args1)
    p args1
    puts "hello"
    yield
  end
  
end

class Hello
  include MyModule
  
  def greet_with_logger?(args1)
    p args1
    puts "--logger begin"
    greet_without_logger?(args1){p "bye"}
    puts "--logger end"
    yield
  end 
  
  chained_aliasing :greet?, :logger
end

Hello.send(:include, MyModule)

say = Hello.new
say.greet?(1){ p "bye"}
#say.greet_with_logger?(1){ p "bye"}
#say.greet_without_logger?(1){ p "bye" } 
