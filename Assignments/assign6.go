////////////////////////////       assign6			///////////////////////

///// Felix Singerman 
///// 7970742


package main
import (
    "bufio"
    "fmt"
    "os"
			)


/////////////// Question 1. Sosd [3 marks] ///////////////


// a) Create a function sosd in GO that calculates the sum of square digits.

   func sosd( num int ) int{
    sum := 0
    for num > 0 {
      square :=  num % 10
      num = num/10
      sum = sum + square * square
      }
      return sum
   }







/* It has been shown that for any starting number, the series described 
 will always reach one of the following numbers: 0,1,4,16,20,37,42,58,89,145 
 In the following I call these numbers stop numbers. If the series reaches 
 the number 1 for a starting number H, then the number H is called a 
 'happy number'.

 b) Write a function stop in GO that is true if the argument is one of the 
 stop numbers in the above list.  */


func stop( num int) bool {
    
    for _, stop := range []int{0,1,4,16,20,37,42,58,59,145} {
     if num == stop{
      return true
     }
     
    }
      return false
  }




/* c) Create a function sosd_series that returns a list containing all the 
sum of square digits calculated until (and including) a stop number is reached.
Hint: You can use append to implement a “growable array” for the slice to be
 returned	*/

func sosd_series( num int) []int{

  newnum := []int{num}
  for num>0{
    if(sosd(num)) != stop(num) {
      solution = append(newnum, sosd(num)) }
      return solution
    }
    return false
}







// d) Create a function happy? that returns true if the function ssod_series 
// ends in a 1. 


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


func main(){

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







///////////////////// Question 2. [2 marks] /////////////////////



/* Change the following program to concurrently interpolate between the 
 start and endpoint by turning the method linear into a go routine 
 (a function) and sending each result on a separate channel to the 
 main program. Use a select statement for the print loop to react to 
 the sent interpolation values and print them as they are received. 
 Add a timeout in the select to ensure your program terminates.

 Hint: In order not having to hard-code the array indices in the select 
 statement, you may use intermediate go routines to receive an interpolation 
 value and resend them on a common channel. */


// view  q2.go 




