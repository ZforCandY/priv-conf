#lang scheme
(display "Hello,world!\n")

;;;Lists, Strings
;;1
(define prob1
  (lambda (l)
    (cond
      ((null? l)'())
      ((eq? (cdr l) '())(car l))
      ((> (string-length
           (symbol->string
            (car l)))
          (string-length
           (symbol->string
            (car(cdr l)))))
       (prob1
        (cons (car l) (cdr(cdr l)))))
      ((prob1 (cdr l)))
      )))

(prob1 '(linux bsd windows mac_os you_name_it))

;;2
(define prob2
  (lambda (l)
    (cond
      ((null? l)'())
      ((eq? (cdr l) '())l)
      (else
       (append
        (prob2 (cdr l))
        (list(car l))
        )
       ))))

(prob2 '(place. in
               ,preferably list a reverses
                that function Write))

;;3
(define prob3
  (lambda (e l)
    (cond
      ((and(eq? e '())
          (eq? l '()))
       #t)
      ((or(eq? e '())
          (eq? l '()))
       #f)
      ((eq? e (car l))
       #t)
      ((prob3 e (cdr l)))
      (else #f)
      )))

(prob3 'as '(be f fuck asm a lol))

;;4
(define prob4
  (lambda (l)
    (cond
      ((null? l)'())
      ((eq?(cdr l)'())l)
      (else
       (cons
        (car l)
        (prob4 (cddr l)))))))

(prob4 '(1 2 3 4 5 6 7 8 9 10 11))

;;5
(define prob5
  (lambda (l)
    (define count 0)
    (define (1+ x) (+ x 1))
    (cond
      ((null? l)0)
      ((eq?(cdr l)'())1)
      (else
       (+
        (1+ count)
       (prob5 (cdr l)))))))

(prob5 '(foo bar baz 3.14 = pi))

;;6
(define prob6
  (lambda (l)
    (cond ((equal? (prob2 l) l)#t)
          (else #f))))

(prob6 '(L O L O L))

;;7

(define prob7-recursion
  (lambda (l)
    (if (number?(car l))
    (cond
      ((null? l)0)
      ((eq?(cdr l)'())(car l))
      (else
       (+
        (car l)
        (prob7-recursion(cdr l)))
       ))
    0)))

(prob7-recursion '(1 9 8 9 6 4))
(prob7-recursion '(* slay 666 lambs))

(define prob7-for
  (lambda (l)
    (let loop ((i 1))
    (when (not(<= i 0))
      (display (prob7-recursion l))
      (loop (- i 1))
    ))))

(prob7-for '(1 3 5 7 9 11 13 17))

(define prob7-while
  (lambda (l)
    (when (not(number? l))
      (display (prob7-recursion l))
    )))

(prob7-while '(-15 0 -99 37))

;;8
(define prob8
  (lambda (l)
    (define (sqr e) (* e e))
    (cond
      ((null? l)0)
      ((eq?(cdr l)'())(sqr(car l)))
      (else
       (cons
        (sqr(car l))
        (prob8(cdr l))
        )
       ))))

(prob8 '(1 2 3 4 5 6 7 8 9 10 11 12))

;;9
(define prob9
  (lambda (l1 l2)
    (if (and (pair? l1)
             (pair? l2))
        (append l1 l2)
        #f)))

(prob9 '(a b c) '(1 2 3))
(prob9 'a '(b c))

;;10
(define prob10
  (lambda (l1 l2)
    (if (eq? l1 '())
        l2
        (if (eq? l2 '())
            l1
            (cond
              ((not(eq? (car l1) '()))
               (cons(car l1)
                    (prob10 l2 (cdr l1))
              )))))))

(prob10 '(a b c) '(1 2 3))

;;11
;;WIP
(define prob11
  (lambda (l1 l2)
    (let ((l3 (prob10 l1 l2)))
    (if (eq? l1 '())
        l2
        (if (eq? l2 '())
            l1
            l3)))))
    (prob11 '(1 4 6) '(2 3 5))

;;12

;;13
;;recursion slow after 40+
(define prob13-recursion
  (lambda (n)
    (cond
      ((<= n 2)1)
      (else
       (+ (prob13-recursion(- n 1))
          (prob13-recursion(- n 2))))
      )))

(define fib-Binet
  (lambda (n)
    (define (1+ x) (+ x 1))
    (round
     (/ (expt (/ (+ 1 (sqrt 5)) 2) (1+ n))
        (sqrt 5)))))

(time
(do ((i -1 (+ i 1)))  ;;after 94 e+ occur
     ((= i 100) 'done) ;;scheme_max=1474 till +inf.0
   (display (fib-Binet i))
   (newline)))

