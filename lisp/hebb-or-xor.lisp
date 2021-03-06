;; Author: Pedro Fernandes
;; Hebb Rules - Erro do XOR(6) and OR(9)
;; 17/08/2020

(defvar *linear* 0)

(defvar *sources*
  (make-array '(4 2) :element-type '(signed-bit 3)
	      :initial-contents '(( 1  1)
				  (-1  1)
				  ( 1 -1)
				  (-1 -1)) ))

(defvar *target*
  (make-array '(16 4) :element-type '(signed-bit 3)
	      :initial-contents '((-1 -1 -1 -1) ;; bits 0000 - 0
				  (-1 -1 -1  1) ;; bits 0001 - 1
				  (-1 -1  1 -1) ;; bits 0010 - 2
				  (-1 -1  1  1) ;; bits 0011 - 3
				  (-1  1 -1 -1) ;; bits 0100 - 4
				  (-1  1 -1  1) ;; bits 0101 - 5
				  (-1  1  1 -1) ;; bits 0110 - 6
				  (-1  1  1  1) ;; bits 0111 - 7
				  ( 1 -1 -1 -1) ;; bits 1000 - 8
				  ( 1 -1 -1  1) ;; bits 1001 - 9
				  ( 1 -1  1 -1) ;; bits 1010 - 10
				  ( 1 -1  1  1) ;; bits 1011 - 11
				  ( 1  1 -1 -1) ;; bits 1100 - 12
				  ( 1  1 -1  1) ;; bits 1101 - 13
				  ( 1  1  1 -1) ;; bits 1110 - 14
				  ( 1  1  1  1) ;; bits 1111 - 15
				  )))


(defparameter *results* nil)

(defun from-calculus(id)
  (let ((b 0) (w (make-array 2)))
    (loop for i from 0 to 3
	  do (progn
	       
	       (setf (aref w 0) (+ (aref w 0)
				   (* (aref *sources* i 0)
				      (aref *target* id i))))
		     
	       
	       (setf (aref w 1) (+ (aref w 1)
				   (* (aref *sources* i 1)
				      (aref *target* id i))))
		     
	       (setf b (+ b (aref *target* id i)))
	       ))
    
    (list b w)))

				   
(defun train()
  (setf *results* (loop for i from 0 to 15
			collect (from-calculus i))))


(defun predict(result id)
  (+ (* (aref (cadr result) 0) (aref *sources* id 0))
     (* (aref (cadr result) 1) (aref *sources* id 1))
     (car result)))
     

(defun imprimir(&optional (r *results*))
  (if (null r) t
    (progn
      (loop for j from 0 to 3 do
	    (format t "~a | ~a => ~a ~%"
		    (if (= (aref *sources* j 0) -1) "-1" " 1" )
		    (if (= (aref *sources* j 1) -1) "-1" " 1")
		    (if (> (predict (car r) j) *linear*) " 1" "-1")))
      (terpri)
      (imprimir (cdr r)) )))
    
			   
;; Use:
;; (train)
;; (imprimir)

#|
 1 |  1 => -1
-1 |  1 => -1
 1 | -1 => -1
-1 | -1 => -1

 1 |  1 => -1
-1 |  1 => -1
 1 | -1 => -1
-1 | -1 =>  1

 1 |  1 => -1
-1 |  1 => -1
 1 | -1 =>  1
-1 | -1 => -1

 1 |  1 => -1
-1 |  1 => -1
 1 | -1 =>  1
-1 | -1 =>  1

 1 |  1 => -1
-1 |  1 =>  1
 1 | -1 => -1
-1 | -1 => -1

 1 |  1 => -1
-1 |  1 =>  1
 1 | -1 => -1
-1 | -1 =>  1

 1 |  1 => -1
-1 |  1 => -1
 1 | -1 => -1
-1 | -1 => -1

 1 |  1 => -1
-1 |  1 =>  1
 1 | -1 =>  1
-1 | -1 =>  1

 1 |  1 =>  1
-1 |  1 => -1
 1 | -1 => -1
-1 | -1 => -1

 1 |  1 => -1
-1 |  1 => -1
 1 | -1 => -1
-1 | -1 => -1

 1 |  1 =>  1
-1 |  1 => -1
 1 | -1 =>  1
-1 | -1 => -1

 1 |  1 =>  1
-1 |  1 =>  1
 1 | -1 => -1
-1 | -1 => -1

 1 |  1 =>  1
-1 |  1 =>  1
 1 | -1 => -1
-1 | -1 => -1

 1 |  1 =>  1
-1 |  1 =>  1
 1 | -1 => -1
-1 | -1 =>  1

 1 |  1 =>  1
-1 |  1 =>  1
 1 | -1 =>  1
-1 | -1 => -1

 1 |  1 =>  1
-1 |  1 =>  1
 1 | -1 =>  1
-1 | -1 =>  1

#|
