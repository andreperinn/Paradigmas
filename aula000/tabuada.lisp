(format t "Hello, World!~%")

(format t "Digite o numero da tabuada: ")
(finish-output)

(let ((num (parse-integer (read-line)))
      (numtabuada 1))

  (loop
    (let ((result (* num numtabuada)))
      (format t "~d x ~d = ~d~%"
              num
              numtabuada
              result))

    (incf numtabuada)

    (when (> numtabuada 10)
      (return))))


