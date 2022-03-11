;11.
;a)Determine the least common multiple of the numerical values of a nonlinear list.
;b)Write a function to test if a linear list of numbers has a "mountain" aspect
; (a list has a "mountain" aspect if the items increase to a certain point and then decreases. Eg. (10 18 29 17 11 10). 
;  The list must have at least 3 atomsto fullfil this criteria.
;c)Remove all occurrences of a maximum numerical element from a nonlinear list.
;d)Write a function which returns the product of numerical even atoms from a list, to any level.
;a) least common multiple for a non linear list
;_gcd(a,b) = null, a and b are not numbers
;          = b, a is not a number
;          = a, b is not a number
;          = a, a=b
;          = _gcd(a-b,b), a>b
;          = _gcd(a,b-a), b>a
(defun _gcd (a b)
  (cond
  ((and (not (numberp a)) (not (numberp b))) nil)
  ((not (numberp a)) b)
  ((not (numberp b)) a)
  ((equal a b) a)
  ((> a b) (_gcd (- a b) b))
  ((< a b) (_gcd a (- b a)))
  )
)
;_lcm(a,b) = null, a and b aren't numbers
;          = b, a is not a number
;          = a, b is not a number
;          = a*b/_gcd(a,b), otherwise
(defun _lcm (a b)
  (cond
  ((and (not (numberp a)) (not (numberp b))) nil)
  ((not (numberp a)) b)
  ((not (numberp b)) a)
  (T (/ (* a b) (_gcd a b)))
  )
)
;list_lcm(l1...ln) = l1, n=1 and atom(l1)
;                  = _lcm(list_lcm(l1),list_lcm(l2..ln)),l1 is a list
;                  = _lcm(l1,list_lcm(l2..ln), otherwise
(defun list_lcm (l)
  (cond
  ((and (atom (car l)) (null (cdr l))) (car l))
  ((listp (car l)) (_lcm (list_lcm (car l)) (list_lcm (cdr l))))
  (T (_lcm (car l) (list_lcm (cdr l))))
 )
)

;b) test if a linear list of numbers has a "mountain" aspect
;_mountain(l1...ln,inc,dec) = dec, n=1
;                           = false, l1>l2 and inc=false                     
;                           = _mountain(l2..ln,true,dec), l1<l2 and dec=false           
;                           = _mountain(l2...ln,inc,T) , l1>l2 and dec=false
;                           = false, l1<l2 and dec = true
;                           = _mountain(l2...ln,inc,dec),otherwise
(defun _mountain (l inc dec)
  (cond
  ((= (list-length l) 1) dec)
  ((and (> (car l) (cadr l)) (null inc)) nil)
  ((and (< (car l) (cadr l)) (null dec)) (_mountain (cdr l) T dec))
  ((and (> (car l) (cadr l)) (null dec))( _mountain (cdr l) inc T))
  ((and (< (car l) (cadr l)) dec) nil)
  (T (_mountain (cdr l) inc dec))
  )
)
;test_mountain(l1..ln) = false, n<3
;                       = _mountain(l1..ln,false,false), otherwise
(defun test_mountain(l)
  (cond
  ((< (list-length l) 3) nil)
  (T (_mountain l nil nil))
  )
)
;c)Remove all occurrences of a maximum numerical element from a nonlinear list
;find_max(l1..ln,max) = max , n = 0
;                     = find_max(l2..ln,l1), atom(l1) and number(l1) and l1>max
;                     = find_max(l2..ln, find_max(l1,max)), list(l)
;                     = find_max(l2..ln,max), otherwise
(defun find_max (l max)
  (cond
   ((null l) max)
   ((and (and (atom (car l)) (numberp (car l))) (> (car l) max)) (find_max (cdr l) (car l)))
   ((listp (car l)) (find_max (cdr l) (find_max (car l) max)))
   (T (find_max (cdr l) max))
  )
)
;remove_max(l1..ln,max) = [] , n = 0
;                       = remove_max(l1,max) U remove_max(l2..ln,max) , list(l1)
;                       = remove_max(l2..ln) , max = l1
;                       = l1 U remove_max(l2..ln) , otherwise
(defun remove_max(l max)
  (cond
   ((null l) nil)
   ((listp (car l)) (cons (remove_max (car l) max) (remove_max (cdr l) max)))
   ((equal (car l) max) (remove_max (cdr l) max))
   (t (cons (car l) (remove_max (cdr l) max)))
)
)

(defun res_c (l)
  (remove_max l (find_max l -10000))
)

;d)Write a function which returns the product of numerical even atoms from a list, to any level
;product(l2..ln,p) = p , n = 0
;                  = product(l2..ln,l1*p) , l1 is even
;                  = product(l2...ln,product(l1,p)), list(l1)
;                  = product(l2...ln,p), otherwise
(defun product(l p)
  (cond
   ((= (list-length l) 0) p)
   ((and (and (atom (car l)) (numberp (car l))) (evenp (car l))) (product (cdr l) (* p (car l))))
   ((listp (car l)) (product (cdr l) (product (car l) p))) 
   (T (product (cdr l) p))
   )
)
;res_d(l1..ln) = 0, product(l1..ln,1)= 1
;              = product(l1..ln,1) , otherwise 
(defun res_d(l)
  (cond
  ((= (product l 1) 1) 0)
  (T (product l 1))
  )
)