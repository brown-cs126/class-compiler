(define (sum n total)
  (if (zero? n)
    total
    (sum (sub1 n) (+ n total))))
(print (sum (read-num) 0))

(define (f x) (+ 2 x))
(define (sum-f n total)
  (if (zero? n)
    total
    (sum-f (sub1 n) (+ (f n) total))))
(print (sum (read-num) 0))
























(define (even n) (if (zero? n) true (odd (sub1 n))))
(define (odd n) (if (zero? n) false (even (sub1 n))))
(print (even (read-num)))

(or false (f 3))