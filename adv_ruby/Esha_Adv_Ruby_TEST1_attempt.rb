
module IncludeAttempt
  def attempt(*args, &block)
    if !(self.nil?)
      if !(args.empty?)
        m = args.slice!(0)
        if(self.class == Class)
          p self.send(m)
          if(block_given?)
            block.call
          end
        elsif(self.class == Article)
          p args[0].send(m)
          if(block_given?)
            block.call
          end
        else
          p self.send(m, *args, &block)
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
end

article = Article.new
#article = nil
getter = Article.new("heya")
#Article.attempt(:superclass) {puts "hi"}
# article.attempt(:reverse, "abcd")
# "abc".attempt(:reverse)
#[1,2,3].attempt(:count)
# Article.attempt(:author)
#getter.attempt(:author)
#article.attempt(:author)
#article.attempt(:author) {puts "hmm"} 
