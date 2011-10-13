def pascal(n)
	arr=[1]          #every time initialize array to 1.
	while(arr.length<n+2)   #condition to print array.
		puts arr.join(" ")            #printing array
		arr=Array.new(arr.length+1){|i|       #creating new array with +1 size.
		  if(i<arr.length)
		    a = arr[i]                #a stores element of current-1 index of prev array.
		  else
		    a = 0
		  end
		  if(i>0)
		    b = arr[i-1]         #a stores element of current index of prev array.
		  else
		    b=0
		  end
			a+b              #a and b added to get element of current index of new array.
			}
	end
end
pascal(6)       
pascal(4)