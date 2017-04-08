;;      lab9

;;question 1

(define (sum-list L)
  (sum-list-acc 0 L))

(define (sum-list-acc S L)
  (if(null? L)
     S
     (sum-list(+(car L)S)(cdr L))))

;; question 2
(define (slice l i k)
   (if(cond(list? l) (not(null? l)))
      (slice-cut l i k 1)
      'Error))

(define(slice-cut l i k c)
  (cond
    ((null? l) '())
    ((< c i) (slice-cut(cdr l) i k(+ i c)))
    ((< c k) (cons(car l) (slice-cut(cdr l) i k (+ 1 c))))
    (slice '())))
     
(slice '(a b c d e f g h i k) 3 7)

;; question 3

(define (reduce F F0 L)
  (if (null? L)
      F0
      (F (car L)
         (reduce F F0 (cdr L)))))

(define (div2sum l)
  (reduce +0 (map(lambda(x)(/ x 2))l)))     


;; question 4  quiz 

(define (div2? l)
  (if(null? l)
     #t
     (if(not(=(modulo (car l)2)0))
             #f
        (div2? (cdr l)))))








