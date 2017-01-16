(defparameter V 16)
(defparameter INF 99999)

(defun delimiterp (c) (position c " ,.;/"))

(defun my-split (string &key (delimiterp #'delimiterp))
  (loop :for beg = (position-if-not delimiterp string)
    :then (position-if-not delimiterp string :start (1+ end))
    :for end = (and beg (position-if delimiterp string :start beg))
    :when beg :collect (subseq string beg end)
    :while end))

(defun print_path(i j last graph)

	(if (= (aref last i j) -1)

		(progn
			(if (not (= (aref graph i j) INF) )
				(format t "~D -> ~D   " i j)
				(format t "No path possible!!") 
			)
			(return-from print_path 0)
		)
	)

	(print_path i (aref last i j) last graph)
	(print_path (aref last i j) j last graph)

)

(defun main()

	; Read input test case
	(princ "Enter test case file name: ")
	(setq fname (read))

	; Hostel ids defined
	(setq hostels '("0 -> subhansri" "3 -> lohit" "4 -> dibang" "5 -> kapili" "6 -> brahmputra" "7 -> dihing" "10 -> umiam" "11 -> manas" "14 -> barak" "15 -> kameng"))
	(princ "Following is the list of hostels. Enter the ID corresponding to a hostel.") (terpri)
	(loop for idx in hostels
		do (princ idx)
		do (terpri)
	)

	; Initial graph with 16 nodes
	(setf 
		graph		
		(make-array 
			(list V V) 
  			:initial-contents 
   			'(
				(0 INF INF INF INF INF INF INF INF INF INF INF INF INF INF INF)
				(INF 0 INF INF INF INF INF INF INF INF INF INF INF INF INF INF)
				(INF INF 0 INF INF INF INF INF INF INF INF INF INF INF INF INF)
				(INF INF INF 0 INF INF INF INF INF INF INF INF INF INF INF INF)
				(INF INF INF INF 0 INF INF INF INF INF INF INF INF INF INF INF)
				(INF INF INF INF INF 0 INF INF INF INF INF INF INF INF INF INF)
				(INF INF INF INF INF INF 0 INF INF INF INF INF INF INF INF INF)
				(INF INF INF INF INF INF INF 0 INF INF INF INF INF INF INF INF)
				(INF INF INF INF INF INF INF INF 0 INF INF INF INF INF INF INF)
				(INF INF INF INF INF INF INF INF INF 0 INF INF INF INF INF INF)
				(INF INF INF INF INF INF INF INF INF INF 0 INF INF INF INF INF)
				(INF INF INF INF INF INF INF INF INF INF INF 0 INF INF INF INF)
				(INF INF INF INF INF INF INF INF INF INF INF INF 0 INF INF INF)
				(INF INF INF INF INF INF INF INF INF INF INF INF INF 0 INF INF)
				(INF INF INF INF INF INF INF INF INF INF INF INF INF INF 0 INF)
				(INF INF INF INF INF INF INF INF INF INF INF INF INF INF INF 0)
			
   			)
   		)
	)

	; Update graph
	(let ((in (open fname :if-does-not-exist :error)))
	   (when in
	      (loop for line = (read-line in nil)
	      	while line do (progn
	      				(setq tempEdge (my-split line))
	      				(setf (aref graph (parse-integer (nth 0 tempEdge)) (parse-integer (nth 1 tempEdge))) (parse-integer (nth 2 tempEdge)))
	      				)
	      )
	      (close in)
	   )
	)

	; (format t "The input graph is as follows-~% ~D~%~%" graph)

	(setf dist (make-array (list V V) ) )
	(setf last (make-array (list V V) ) )

	(dotimes (i V)
		(dotimes (j V) 
			(setf (aref graph i j) (eval (aref graph i j) ) )
			(setf (aref dist i j) (aref graph i j))
			(setf (aref last i j) -1)
		)
	)

	; Floyd–Warshall algorithm
	(dotimes (k V)
		(dotimes (i V)
			(dotimes (j V)

				(if 
					(< 
						(+ (aref dist i k ) (aref dist k j) ) 
						(aref dist i j) 
					)

					(progn

						(setf
							(aref dist i j)
							(+ (aref dist i k ) (aref dist k j) )
						)

						(setf 
							(aref last i j)
							k
						)
					)
				)
			)
		)

	)
	; Get the path if possible
	(princ "Enter source hostel ID: ")
	(setq src_node (read))
	(princ "Enter destination hostel ID: ")
	(setq dst_node (read))

	(print_path src_node dst_node last graph)
)

(main)