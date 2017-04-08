#lang racket

;; question 1
(cons 3 '(4))
(cons '1 '(2 3))
(cons 'a '((b c)))
(cons '1 '())
(cons '2 '((3(4))))


;;question 2
(define (range start stop)
	(if (= start stop)
		(list stop)
		(cons start
			(range (+ start 1)
				stop))))
(range 4 9)


;;question 3
(define (drop l number)
	(if (= number 1)
		(cdr l)
		(cons (car l)
			(drop (cdr l)
				(- number 1)))))
(drop '(1 2 3 4 5 6 7 8 9) 2)



;;question 4 quiz
(define (access l element)
   (if (null? l)
       #f
       (if (equal? element (car l))
                  (list element)
                  (if (list? (car l))
                      (access (car l) element)
             (access (cdr l) element)))))
             
(access '(1 (2 a 4 5)) 'a)    





   