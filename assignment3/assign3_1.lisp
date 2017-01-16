; Function to check if a number is prime
(defun isPrime(n)
    (setf flag 1)
    (do ((i 2 (+ i 1) )) ((= i  n))
        (if (= 0 (mod n i)) (setf flag 2))
    )

    (return-from isPrime flag)
)


; Function to compute sum of roll numbers
(defun sumNum(n)
        (setf num n sumVal 0)
        (loop while (/= n 0) do
            (setf digit (mod n 10))
            (setf sumVal (+ sumVal digit))
            (setf n (floor n 10))
        )
        (setq temp (isPrime sumVal))
        (if(= temp 1)
        	(progn
        	; (print sumVal) 
        	(print num)
        	)
        )
)

; Read the file and store the roll numbers
(defun read-array (filename)
  (with-open-file (in filename)
    (loop for num = (read in nil)
          until (null num)
          collect num)))

(princ "Enter file name: ")
(setq fname (read))
(setq nums (read-array fname))
(loop for x in nums
	do (sumNum x))