;;;;;;;;;;;;;;;;;;;;;;;;;       assign4			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Felix Singerman 
;; 7970742



;;;;;; Question 1. Happy Number ;;;;;;

;; A. Create a function sosd that calculates the sum of square digits. 
;; Example: (sosd 130)
;; --> 10

(define (sosd number)
	(if (= number 1)
            1
            (if(= number 0)
            0
            (+ (*(modulo number 10) (modulo number 10))
               (sosd (floor(/ (- number (modulo number 10))
                       10)))))))

(sosd 120)



;; It has been shown that for any starting number, the series described will 
;; always reach one of the following numbers: 0,1,4,16,20,37,42,58,89,145 
;; In the following I call these numbers stop numbers. If the series reaches 
;; the number 1 for a starting number H, then the number H is called 
;; a 'happy number'.

;; B. Write a function stop? that is true if the argument is one of the 
;; 		stop numbers in the above list. 
;;		(stop? 42)
;;		-->#t 
;;		(stop? 31)
;;		-->#f


(define (stop? number)
	(if(member number '(0 1 4 16 20 37 42 58 89 145))
	#t
        #f))


(stop? 42)
(stop? 31)





;; C. Create a function ssod_series that returns a list containing all 
;;	  the sum of square digits calculated until (and including) a 
;;	  stop number is reached.
;;      (ssod_series 120)
;;  	-->(5 25 29 85 89)


(define(sosd_series number)
      (if(= number  0)
        (list 0)
                (if(= number 1)
                    (list 1)
                    (cond((stop? number)
                         '())
                         (else(append(list(sosd number)) (sosd_series(sosd number))))))))


(sosd_series 1)
(sosd_series 0)
(sosd_series 2)
(sosd_series 120)

;; D. Create a function happy? that returns true if the function ssod_series 
;;	   ends in a 1. 
;;		Example: (happy? 44)
;;					-->#t
;;				(happy? 120)
;;					-->#f



(define (happy? number)
	(if(member 1 (sosd_series number))
		#t
		#f))

;; it is not neccesary to check if it ends in 1, instead we can 
;; check if one appears in the list since once 1 appears, we know it will
;; be the last one. 
;;I could have solved it by using the built in function reverse
;;then use car in order to get the first element in the list
;; the solution below would work as well

;(define(happy? number)
;  (if(= 1(car(reverse(sosd_series number))))
;    #t
;    #f))

(happy? 1)
(happy? 44)
(happy? 120)
















