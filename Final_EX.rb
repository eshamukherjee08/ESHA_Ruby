class Dictionary
  $wrong_word = ""                      #global variable to store the provided wrong word.
  $no_option = ""                       #global variable to store the number of options user wants to provide.
  $option_list = Array.new              #a global array to store the option's list
  $funny = Array.new                    #global array to store match for each individual option wrt to wrong word.
  def wrong_and_option(wrong, option)   #function to take input of wrong word and number of options.
    $wrong_word = wrong
    $no_option = option
  end
  def option_list(*args)                #function to accept variable length option list.
    $option_list = args
    process                             #calling function process at line no. 14
  end
  def process
    array = $option_list
    wrong_word = $wrong_word
    no_option = $no_option
    if(array.size == no_option.to_i)   #if number of options mentioned = no.of options provided
      for i in 0...array.size
      lcs(wrong_word, array[i].to_s)   #call function lcs (line no:31) for each option word
    end
    else
      abort "Wrong no.of options"      #else abort the whole process.
    end
    print "The Wrong word is : #{wrong_word}\n"
    print "The number of possible word options : #{no_option}\n"
    print "The provided options are : \n"
    array.each_with_index{|x,i| print "#{i+1}. #{x}\n"}
    compare                                    #calling function compare (line no:62) to find largest match(s) and display
  end
  def lcs(a, b)                                #function to find largest match of substring for each option wrt wrong word.
      result=""                                #stores resulted sub-string
      arr=Array.new(a.size){Array.new(b.size)} #2D array to match occurance.
      len=0                                    #to store largest num in array that denotes longest match.
      ls_str=0                                 #to store the last sub-string.
      a.scan(/./).each_with_index{|l1,i|
        b.scan(/./).each_with_index{|l2,j|
          if l1==l2                            #if-main start, comapring each letter
            if (i==0 || j==0)                  #if-1 both index 0 then store 1 initially
              arr[i][j]=1
            else
              arr[i][j] = 1 + arr[i-1][j-1]    #else add one to diagonal value to count num of letters matched.
            end                                #end of if-1
            if arr[i][j] > len                 # if-2...increasing value of len.
              len = arr[i][j]
              cur_s = i
              cur_s -= arr[i-1][j-1] unless (arr[i-1][j-1].nil?)   
                if ls_str==cur_s               #if-2.1
                  result+=a[i,1]
                else
                  ls_str=cur_s
                  result=a[ls_str, (i+1)-ls_str]
                end                           #end of if-2.1
            end                               #end of if-2
          else                                #else-main, if no match then store 0.
            arr[i][j]=0
          end                                 #end of if-main
        }
      }
      $funny << result                        #filling array with all matches
  end
  def compare                                 #function to find longest match(s)
   fk, mat = $funny, $option_list
   max= ""                                    #to store match of max length.
   wat = Array.new                            #array of correct possible words.
   #wat1 = ""
   for i in 0...fk.size
   if(max.length <= fk[i].length)
     max = fk[i]                               #storing match of largest length.
     wat << mat[i]                             #putting corresponding word in array of correct possible words.
     #wat1 = mat[i]
   end
   end
   print "\nThe match(s) for your word is :\n"
   wat.each{|x| puts x}
  end
end
a = Dictionary.new
a.wrong_and_option("remimance","3")
a.option_list("remember","reminiscence","remembrance") 