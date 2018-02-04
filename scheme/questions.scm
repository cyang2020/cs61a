(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.

(define (map proc items)
  (if (null? items);base case 
      nil
      (cons (proc (car items)) (map proc (cdr items))));recursive case + first item 
  )


(define (cons-all first rests)
(map (lambda (rest) (cons first rest)) rests)
)

(define (zip pairs)
  (list (map car pairs) (map (lambda (pair) (car (cdr pair))) pairs))
)
  ;iinput pairs is a list of lists 
  ;return a list of first element and second element 
   ;strategy: first get all the first element; then get all the second element; then combine them together 
  ;f
  ;scm> (list '(1) '(2))
      ;((1) (2))
  ;scm> (zip '((1 2) (3 4) (5 6)))
  ;   ((1 3 5) (2 4 6)) - 
 

;; Problem 17
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 17
  (define (helper s i ret) 
    (if (null? s)
      ret
      (helper (cdr s) (+ i 1) (append ret (list(list i (car s)))))
      )
  )
    (helper s 0 nil)
)
  ;def (enumerate s) 
  ;ret = []
  ; i = 0
  ; while ret is not empty: 
  ;   ret.append(list i s.first)
  ;   s = s.rest 
  ; return ret 
  ;END PROBLEM 17

;; Problem 18
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN PROBLEM 18
  (cond 
    ((= total 0) (list nil))
    ((null? denoms) nil)
    ((< total 0) nil)
    ((> (car denoms) total) (list-change total (cdr denoms)));with out first 
    (else (append (cons-all (car denoms) (list-change (- total (car denoms)) denoms)) (list-change total (cdr denoms))));with first + without first 
  )
  )
  ; END PROBLEM 18

;; Problem 19
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (cons form (cons params (map let-to-lambda body)))
           ; END PROBLEM 19
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
               ;(define (caar x) (car (car x)))
              ; (define (cadr x) (car (cdr x)))
              ;(define (caar x) (car (car x)))
           ; BEGIN PROBLEM 19
           (cons (cons 'lambda (cons (car (zip values)) 
              (map let-to-lambda body))) 
                (cadr (zip (map let-to-lambda values))))
           ;scm> (let-to-lambda '(let ((a 1) (b 2)) (+ a b)))
                                ;((lambda (a b) (+ a b)) 1 2)
                                ;values - ((a 1) (b 2))
                                ;body - (+ a b)
           ; END PROBLEM 19
           ))
        (else
         ; BEGIN PROBLEM 19
         (map let-to-lambda expr)
         ; END PROBLEM 19
         )))
