;4.
;transform(l1...ln) = null , n = 0
;                   = l1 U 0, l2 = null and l3 = null
;                   = l1 U 1 U transform(l3), l2 = null
;                   = l1 U 1 U transform(l2), l3 = null
;                   = l1 U 2 U transform(l2) U transform(l3), otherwise
(defun transform(l)
    (cond 
        ((null l) nil)
        ((and (null (cadr l)) (null (caddr l))) (append (list (car l)) (list 0)))
        ((and (null (cadr l)) (not (null (cddr l)))) (append (list (car l)) (list 1) (transform (cddr l))))
        ((and (null (cddr l)) (not (null (cadr l)))) (append (list (car l)) (list 1) (transform (cadr l))))
        (t (append (list (car l)) (list 2) (transform (cadr l)) (transform (caddr l))))
    )
)

(print (transform '(A (B) (C (D) (E)))))
(print (transform '(A(B(D)(E(F(G)(H))))(C(I(J(K)))))))