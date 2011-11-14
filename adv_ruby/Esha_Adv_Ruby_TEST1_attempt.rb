
module IncludeAttempt
  def attempt(*args, &block)
    if !(self.nil?)
      if !(args.empty?)
        m = args.slice!(0)
        if(self.class == Class)
          self.send(m)
          if(block_given?)
            block.call
          end
        elsif(self.class == Article)
          args[0].send(m)
          if(block_given?)
            block.call
          end
        else
          self.send(m, *args, &block)
        end
      else
        block.call
      end
    else
      return nil
    end
  end
  def author
    "Here goes the name of author!"
  end
end

Object.send(:include, IncludeAttempt)
class Article
  include IncludeAttempt
  
  def author
    p "author"
  end
  
  def self.author
    "self author"
  end
end

article = Article.new
#article = nil
getter = Article.new("heya")
p Article.attempt(:superclass) {puts "hi"}
# article.attempt(:reverse, "abcd")
p "abc".attempt(:reverse)
p [1,2,3].attempt(:count)
p Article.attempt(:author)
p getter.attempt(:author)
p article.attempt(:author)
#article.attempt(:author) {puts "hmm"} 
