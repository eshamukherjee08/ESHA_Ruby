class Dictionary
  def initialize
    @@option_list, @@avail_list = [], []              # store the option's list read from words.txt   
  end
  
  def check(wrong_word)                         #function to read word repository file and strings matched repectively.
    str =""
    File.open("words.txt","r"){|fileRead| while(line = fileRead.gets)
      str << line
      end
      str.split(/\,/).each{|x| @@option_list << x}
    }
    process(wrong_word)                                   #calling function process at line no. 19
  end

  def process(wrong_word)
    puts "The Wrong word is : #{wrong_word}"
    (0...(@@option_list.size)).each { |i| lcs(wrong_word, @@option_list[i]) }
    compare                                    #calling function compare (line no:62) to find largest match(s) and display
  end

  def lcs(a, b)                                                                    #function to find largest match of substring for each option wrt wrong word.
      arr, len, ls_str, result=Array.new(a.size){Array.new(b.size)}, 0, 0,""             #2D array to match occurance.
      a.scan(/./).each_with_index{|l1,row_indx| b.scan(/./).each_with_index{|l2,col_indx|
          if l1==l2                                                                     #if-main start, comapring each letter
            if (row_indx==0 || col_indx==0)                                             #if-1 both index 0 then store 1 initially
              arr[row_indx][col_indx]=1
            else
              arr[row_indx][col_indx] = 1 + arr[row_indx-1][col_indx-1]    #else add one to diagonal value to count num of letters matched.
            end                                                             #end of if-1
            if arr[row_indx][col_indx] > len                                # if-2...increasing value of len.
              len, cur_s = arr[row_indx][col_indx], row_indx
              cur_s -= arr[row_indx-1][col_indx-1] unless(arr[row_indx-1][col_indx-1].nil?)
                if(ls_str == cur_s)                                         #if-2.1
                  result+=a[row_indx,1]
                else
                  ls_str=cur_s
                  result=a[ls_str, (row_indx+1)-ls_str]
                end                           #end of if-2.1
            end                               #end of if-2
          else                                #else-main, if no match then store 0.
            arr[row_indx][col_indx]=0
          end                                 #end of if-main
        }
      }
      @@avail_list << result                   #filling array with all matches
  end
  
  def compare                                 #function to find longest match(s)
   len = []
   @@avail_list.each{|x| len << x.length}
   maximum, w_match = len.max, []
   (0...(@@avail_list.size)).each { |i| w_match << @@option_list[i] if maximum == @@avail_list[i].length }
   w_match.each{|x| puts x}
  end
end

d = Dictionary.new
d.check("eshyank")