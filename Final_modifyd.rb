class Dictionary
  def initialize(wrong_word)
    @wrong_word = wrong_word
    read_file
  end
  $option_list = Array.new              #a global array to store the option's list read from words.txt
  $avail_list = Array.new               #global array to store match for each individual option wrt to wrong word.
  def read_file                         #function to read word repository file.
    array_for_words = $option_list
    str = ""
    File.open("words.txt","r") do |fileRead|
      while line = fileRead.gets
        str << line
      end
      str.split(/\,/).each{|x| array_for_words << x}
    end
    process                                   #calling function process at line no. 19
  end
  def process
    wrong_word = @wrong_word
    array = $option_list
    puts "The Wrong word is : " + wrong_word
    for i in 0...array.size
      lcs(@wrong_word, array[i])
    end
    compare                                    #calling function compare (line no:62) to find largest match(s) and display
  end
  def lcs(a, b)                                #function to find largest match of substring for each option wrt wrong word.
      result=""                                #stores resulted sub-string
      arr=Array.new(a.size){Array.new(b.size)} #2D array to match occurance.
      len=0                                    #to store largest num in array that denotes longest match.
      ls_str=0                                 #to store the last sub-string.
      a.scan(/./).each_with_index{|l1,row|
        b.scan(/./).each_with_index{|l2,col|
          if l1==l2                            #if-main start, comapring each letter
            if (row==0 || col==0)                  #if-1 both index 0 then store 1 initially
              arr[row][col]=1
            else
              arr[row][col] = 1 + arr[row-1][col-1]    #else add one to diagonal value to count num of letters matched.
            end                                #end of if-1
            if arr[row][col] > len                 # if-2...increasing value of len.
              len = arr[row][col]
              cur_s = row           
              cur_s -= arr[row-1][col-1] unless(arr[row-1][col-1].nil?)
                if ls_str == cur_s               #if-2.1
                  result+=a[row,1]
                else
                  ls_str=cur_s
                  result=a[ls_str, (row+1)-ls_str]
                end                           #end of if-2.1
            end                               #end of if-2
          else                                #else-main, if no match then store 0.
            arr[row][col]=0
          end                                 #end of if-main
        }
      }
      $avail_list << result                   #filling array with all matches
  end
  def compare                                 #function to find longest match(s)
   fk, mat = $avail_list, $option_list
   len = Array.new
   fk.each{|x| len << x.length}
   enum_fk = len.to_enum
   maximum = enum_fk.max_by{|x| x}
   w_match = Array.new
   for i in 0...fk.size
     if(maximum == fk[i].length)
       w_match << mat[i]
     end
   end
   puts "The match(s) for your word is :"
   w_match.each{|x| puts x}
  end
end
a = Dictionary.new("remisance")