;10.Define  a  function  that  replaces  one  node  with  another  one  in  a  n-treerepresented  as:  
;root list_of_nodes_subtree1... list_of_nodes_subtreen) 
;Eg: tree is (a (b (c)) (d) (e (f))) andnode 'b' will be replace with node 'g' => tree (a (g (c)) (d) (e (f)))}
;_replace(l1..ln,x,y) = y, l1= x
;                     = l1, l1 !=x
;                     = replace(l1,x,y) U replace(l2..ln,x,y), l1 = list
(defun _replace(l x y)
  (cond
  ((and (atom l) (= l x)) y)
  ((atom l) l)
  ((listp l) (mapcar #'(lambda (a) (_replace a x y)) l))
  )
)
 (print (_replace '(1 (2 (3)) (4) (5 (6))) 9 10))
