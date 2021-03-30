(define (range lo hi) 
  (if (< lo hi) 
   (pair lo (range (add1 lo) hi)) 
   false))
(define (map f l) 
  (if (not l) l 
  (pair (f (left l)) (map f (right l)))))
(define (g x) (+ x 2))
(print (map g (range 0 2)))


















(define (adder x) (lambda (y) (+ x y)))
(print ((adder 2) 3))

