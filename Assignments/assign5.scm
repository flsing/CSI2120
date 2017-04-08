;;;;;;;;;;;;;;;;;;;;;;;;;       assign5			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Felix Singerman 
;; 7970742



;;;;;; Question 1. De Casteljau Algorithm [3 marks] ;;;;;;

; The De Casteljau algorithm calculates a free-form curve, called the Bezier curve.
; In this example, we use it for interpolation. We are interpolating the input 
; point based on a curve parameter. We want to know all interpolated points 
; at all levels. For simplicity, we use only one-dimensional points. 
; Here is an illustration for four input points 4,12,16,20 
; and curve parameter t = 0.25. 




; A. Create a function deCasteljau that applies the De Casteljau algorithm to a
; list of numbers and returns a list of lists with the result. 
; Example:
; (deCasteljau 0.25 (4 12 16 20))
; -> ((9.75) (8.5 14) (7 13 17) (4 12 16 20))

; Note that your function must work for any length of input list. 
;A list of 4 numbers will produce a list of 4 lists as a result, 
;a list with 5 numbers will produce a list of 5 lists as a result and so on. 



; (define (deCasteljau param points)
;   (cons points
;   (list(list(+(*(- 1 param)(car points))(* param (cadr points)))))))
	

(define deCastel
   (lambda (param points)
  (letrec ((l (length points))
         (newparam (- 1 param))
         (newlist (cons points '())))
  (do ((i 0 (+ i 1)))
       ((= i (- l 1)))
  (cons points
  (append(list(list
    (+(* newparam (list-ref points i)) (* param (list-ref points (+ 1 i))))))
     newlist))
    (deCastel param (cdr points))))))




(deCastel 0.25 '(4 12 16 20))







;; solution for b




; B. Modify your function from part a) using local bindings 
; i.e., the appropriate form(s) of let. For this part of the question, 
; you are not allowed to define any helper function through top-level
; defines. Use instead only local bindings. 
; Example:
; (deCasteljau-local 0.25 (4 12 16 20))
; ((9.75) (8.5 14) (7 13 17) (4 12 16 20))

; Note that if your function deCasteljau is already not using any helper 
; function but let, you may hand-in the same answer for a) and b). 



(define (deCasteljau-local param points))


(define deCasteljau-local
   (lambda (param points)
     (let*((l(length points))
          (newlist (list points)))
       (do ((i 0 (+ i 1)))
         ((= i (- l 1)))
         (let*((newparam (- 1 param))
               (sol (list(+(* newparam (list-ref points i)) (* param (list-ref points (+ 1 i)))))))
           (append (list sol) newlist)
           (deCasteljau-local param (cdr points))
           (deCasteljau-local param newlist)
           (reverse newlist))))))

(deCasteljau-local 0.25 (4 12 16 20))

;alternate solution. 

(define deCastel
   (lambda (param points)
     (let*((l(length points))
          (newlist (list points)))
       (do ((i 0 (+ i 1)))
         ((= i (- l 1)))
         (let*((newparam (- 1 param))
               (sol (list(+(* newparam (list-ref points i)) (* param (list-ref points (+ 1 i)))))))
           ;(deCastel param (cdr points))
           (append sol (car newlist))
           (deCastel param newlist)
           (reverse newlist)(display newlist))))))







;;;;;; Question 2. Vectors in Scheme [2 marks] ;;;;;;



; For this question, you are not allowed to convert the vector into a list.

; The “0-norm” as used by Donoho for discrete vector is defined as the 
; number of non-zero dimensions of a vector. 
; For example, the vector [3,0,2, −4,0,2] has a “0-norm” of 4, while the vector
; [−5,0,0,1,0,0,0,0, −2] has a “0-norm” of 3.

; A. Create a function norm0 that calculates the “0-norm” for integer vectors. 
; Example:
; (norm0 #(3 0 2 4 0 2))
; ->4



; (define norm0
; 	(lambda (vec)
; 		(let ((size (vector-length vec)))
; 			(do ((position 0(+ position 1))
; 				(total 0
; 					(+ total (vector-ref vec position))))
; 			((= position sizze) total)))))

                     
(define norm0
  (lambda (vec)
    (for/sum ((item(in-vector vec)))
      (if (equal? item 0)
          0
          1))))
  


(norm0 #(3 0 2 4 0 2))


;; fully working!


; Vector normalization is dividing each element of a vector by its norm. 
; For example, the a normalization of the vector [3,0,2, −4,0,2] 
; with the “0-norm” produces the vector [0.75,0,0.5, −1,0,0.5].


; B. Create a function normalize0 that normalizes a vector by its 
; “0-norm” calculated in a). 
; Example:
; (normalize0 #(3 0 2 -4 0 2))
; -> #(3/4 0 1/2 -1 0 1/2)



(define normalize0
  (lambda (vec)
    (let* ((newvec(vector-copy vec))
        (l (vector-length vec))
          (norm(norm0 vec))
          )
      (do ((i 0(+ i 1)))
           ((= i l))
        (vector-set*! newvec  i (/(vector-ref vec i)norm)))newvec)))

(normalize0 #(3 0 2 4 0 2))


;; fully working!








