;; Example 1

(define (id x) x)
(print (id 4))

;; Example 2

(define (f x y) (+ x y))
(define (g x) (f x x))
(print (f 4 5))

;; Example 3

(define (fib n) (if (< n 2) n (+ (fib (- n 1)) (fib (- n 2)))))
(print (fib (read-num)))

;; Example 4

(define (even n) (if (zero? n) true (odd (sub1 n))))
(define (odd n) (if (zero? n) false (even (sub1 n))))
(print (even (read-num)))

;; Example 5

(define (fib-helper fib-n-2 fib-n-1 n target)
  (let ((fib-n (+ fib-n-2 fib-n-1)))
    (if (= n target) fib-n (fib-helper fib-n-1 fib-n (add1 n) target))))
(define (fib n)
  (if (< n 2) n (fib-helper 0 1 2 n)))
(print (fib (read-num)))
