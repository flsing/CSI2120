package main

import (
	"fmt"
	"time"
)

func main() {
	ch := make(chan int)
	go func() {
		for i := 0; i < 10; i++ {
		ch <- i
	}
	
	} ()
	go func (){
		for {
		if num, ok := <-ch; !ok {
			break
		} else {
			fmt.Printf("%d\n", num)
		}
	}
	}()
	time.Sleep(2 * time.Second)
	close(ch)
}
