
module IncludeAttempt
  def attempt(*args, &block)
    if !(self.nil?)
      if !(args.empty?)
        m = args.slice!(0)
        if(self.class.name == "Class")
          res = self.send(m, *args, &block)
          if(block_given?)
            b = block
          end
        elsif(self.class.name == "Article")
          res = args.empty? ? (self.send(m)) : (args[0].send(m))
          if(block_given?)
            p "hey"
            b = block
          end
        else
          res = self.send(m, *args, &block)
        end
      else
        block.call
      end
    else
      return nil
    end
    #res
    if(b)
      p 1
      final = b.call
    end
    return res, final
    exit
  end
end

Object.send(:include, IncludeAttempt)
class Article
  include IncludeAttempt
  
  def author
   "author"
  end
  
  def self.author
   "self author"
  end
end
#p Article.methods
article = Article.new
#article = nil
getter = Article.new("heya")
#p Article.attempt(:superclass){puts "hi"}
#p article.attempt(:reverse, "abcd")
#p "abc".attempt(:reverse)
#p [1,2,3].attempt(:count)
#p Article.attempt(:author)
#p getter.attempt(:author)
p article.attempt(:author)
#p article.attempt(:author) {puts "hmm"}
#article = nil
#p article.attempt(:author)
