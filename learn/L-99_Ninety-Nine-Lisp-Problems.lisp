;; L-99: Ninety-Nine Lisp Problems
;;
;; Based on a Prolog problem list by werner.hett@hti.bfh.ch
;;
;; Working with lists
;;P01
(defun my-last (l)
  (cond
    ((= 0 (length l))())
    ((eq (cdr l)())
         (list(car l)))
     (t (my-last(cdr l)
                ))))
(my-last '(a b c d e f g h i j k))

;;P02
(defun my-but-last (l)
  (cond
    ((= 0 (length l))())
    ((= 1 (length(cdr l)))
     (cons (car l)(cdr l)))
    (t (my-but-last (cdr l)))
    ))
(my-but-last '(a b c d e f))

;;P03
(defun element-at (l n)
  (cond
    ((= 0 (length l))())
    ((= n 1)(car l))
    (t (element-at (cdr l) (- n 1)))
    ))
(element-at '(e a b c d e f) 3)

;;P04
(defun find-list-element (l)
  (if l
      (1+ (find-list-element
           (cdr l)))
      0))
(find-list-element '(a b c d e f))

;;P05
(defun reverse-list (l &optional r)
  (if l
      (reverse-list (cdr l)
      (cons (car l)
            r))
      r))
(reverse-list '(a b c d e))

;;P06
(defun palindrome-p (l)
  (if (<= (length l) 1)
  t
  (cond
    ((equalp (reverse-list l) l)t)
    (t ()))))
(palindrome-p '(a b c b a))

;;P07
(defun my-flatten (l)
  (cond
    ((null l)nil)
    ((atom l)(list l))
    (t (append
        (my-flatten (car l))
        (my-flatten (cdr l))))
    ))

(my-flatten '(a (b (c d) e)))

;;P08
(defun compress (l)
  (cond
    ((null l)nil)
    ((eq(cdr l)nil)l)
    ))
