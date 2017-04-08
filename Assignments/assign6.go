// test.go

// go run test.go

// input file I want to test here


package main
import (
    
    "fmt"
    
    "strconv"
			)

   func sosd( num int ) int{
    sum := 0
    for num > 0 {
      square :=  num % 10
      num = num/10
      sum = sum + square * square
      }
      return sum
   }

func stop( num int) bool {
    
    for _, stop := range []int{0,1,4,16,20,37,42,58,59,145} {
   	 if num == stop{
   	 	return true
   	 }
   	}
   		return false
}


func sosd_series( num int) []int{
	
  newnum := []int{num}
  for !(stop(num)){
  	var answer = sosd(num)
      newnum = append(newnum, answer) 
   	  num = answer   
    }
    return newnum
}




func happy(num int) bool{
  for _, happy := range sosd_series(num){
  if(happy == 1){
    return true
  }
}
	return false
}


/* e) Include a main function that in a loop allows the user to enter an 
 integer and in response shows the sosd_series and prints happy or unhappy 
 as appropriate. 
Example:
go run sosd.go
 Enter a positive number (Anything else to exit): 1411
 [19 82 68 100 1]
  Happy
  Enter a positive number (Anything else to exit): 534
  [50 25 29 85 89]
  Unhappy
  Enter a positive number (Anything else to exit): e */

func main() {

    fmt.Println(sosd(24))
    fmt.Println(stop(4))
  	fmt.Println(stop(10))
  	fmt.Println(sosd_series(69))
  	fmt.Println(sosd_series(24))
  	fmt.Println(sosd_series(44))
  	fmt.Println(sosd_series(120))
  	fmt.Println(happy(24))
  	fmt.Println(happy(44))
  	fmt.Println(happy(120))

  	flag := true

  	for flag{
  		var reader string
	    fmt.Print("Enter a positive number (Anything else to exit): ")
	    fmt.Scanln(&reader)
	    text, err := strconv.Atoi(reader)
	    if err != nil {
	    	break
	    }
	    	newnum := sosd_series(text)
	    	fmt.Println(newnum)
	    	
	    	if happy(text){
	    		fmt.Println("happy")
	    	
	    	}else{
	    		fmt.Println("unhappy")
	    	}
	    	
	    }
	    flag = false
	}





