module FilterModule 
  def self.included(klass)

    def klass.method_added(method_name)
      return if (before_hooks.include?(method_name) || hooked_methods.include?(method_name) || after_hooks.include?(method_name))
      hooking_methods(method_name)
    end

    def klass.before_filter(*args)
      before_hooks << args[0]
      before_hash << args[1]
    end

    def klass.after_filter(*args)
      after_hooks << args[0]
      after_hash << args[1]
    end

    # methods that are before hooked.
    def klass.before_hooks
      @before_hooks ||= []
    end

    # methods that are hooked after.
    def klass.after_hooks
      @after_hooks ||= []
    end 

    # only and except after filter
    def klass.after_hash
      @after_hash ||= []
    end

    # only and except before filter 
    def klass.before_hash
      @before_hash ||= []
    end

    # methods that has been hooked
    def klass.hooked_methods
      @hooked_methods ||= []
    end

    def klass.hooking_methods(method_name)
      hooked_methods << method_name
      original_method = instance_method(method_name)
      if(before_hash[0] == nil && after_hash[0] == nil)
        define_method(method_name) do
          method(self.class.before_hooks[0]).call
          original_method.bind(self).call
          method(self.class.after_hooks[0]).call
        end
      else
        if (before_hash[0] != nil)
          if (before_hash[0].has_key?(:only))
            if (after_hash[0] != nil)
              if (after_hash[0].has_key?(:only))
                define_method(method_name) do
                  if(self.class.before_hash[0].values[0].include?(method_name))
                    method(self.class.before_hooks[0]).call
                  end
                  original_method.bind(self).call
                  if(self.class.after_hash[0].values[0].include?(method_name))
                    method(self.class.after_hooks[0]).call
                  end
                end
              else
                define_method(method_name) do
                  if(self.class.before_hash[0].values[0].include?(method_name))
                    method(self.class.before_hooks[0]).call
                  end
                  original_method.bind(self).call
                  if !(self.class.after_hash[0].values[0].include?(method_name))
                    method(self.class.after_hooks[0]).call
                  end
                end
              end
            end
          else
            if (after_hash[0] != nil)
              if (after_hash[0].has_key?(:only))
                define_method(method_name) do
                  if !(self.class.before_hash[0].values[0].include?(method_name))
                    method(self.class.before_hooks[0]).call
                  end
                  original_method.bind(self).call
                  if(self.class.after_hash[0].values[0].include?(method_name))
                    method(self.class.after_hooks[0]).call
                  end
                end
              else
                define_method(method_name) do
                  if !(self.class.before_hash[0].values[0].include?(method_name))
                    method(self.class.before_hooks[0]).call
                  end
                  original_method.bind(self).call
                  if !(self.class.after_hash[0].values[0].include?(method_name))
                    method(self.class.after_hooks[0]).call
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end 

#Class.send(:include, FilterModule)

class Tester
  include FilterModule
  before_filter :foo, :except => [:test2, :test3]
  after_filter :bar, :only => [:test2]
  
  def test1
    puts "Inside Test method 1"
  end
  
  def foo
    puts "inside foo"
  end
  
  def bar
    puts "inside bar"
  end
  
  def test2
    puts "Inside test method 2"
  end
  
  
  def test3
    puts "Inside test method 3"
  end
  
end 

Tester.new.test1
Tester.new.test2
Tester.new.test3