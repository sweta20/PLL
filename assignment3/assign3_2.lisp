; Computes trapezoidal rule
(defun trapezium (f a b n &aux (d (/ (- b a) n)))
  (* (/ d 2)
     (+ (funcall f a)
        (* 2 (loop for x from (+ a d) below b by d summing (funcall f x)))
        (funcall f b))))

; Computes simpson value
(defun simpson (f a b n)
  (loop with h = (/ (- b a) n)
        with sum1 = (funcall f (+ a (/ h 2)))
        with sum2 = 0
        for i from 1 below n
        do (incf sum1 (funcall f (+ a (* h i) (/ h 2))))
        do (incf sum2 (funcall f (+ a (* h i))))
        finally (return (* (/ h 6)
                           (+ (funcall f a)
                              (funcall f b)
                              (* 4 sum1)
                              (* 2 sum2))))))

; The functions f1 f2 f3 are defined
(defun f1 (x) (* 4 x x))
(defun f2 (x) (* 4 (exp x)))
(defun f3 (x) (- (* 4 x x x x) (* 4 x x x)))

(print "Function 1 (4x^2): ")
(print(simpson   'f1 2 4 100))
(print(trapezium 'f1 2 4 100))

(print "Function 2 (4e^x): ")
(print(simpson   'f2 2 4 100))
(print(trapezium 'f2 2 4 100))

(print "Function 3 (4x^4-4x^3): ")
(print(simpson   'f3 2 4 100))
(print(trapezium 'f3 2 4 100))

(print "Mininum cost value:")
(print (min (simpson   'f1 2 4 100) (simpson   'f2 2 4 100) (simpson   'f3 2 4 100) ))
