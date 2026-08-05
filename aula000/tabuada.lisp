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


#|
O salário médio para desenvolvedores que usam a linguagem Lisp ou seus dialetos gira em torno de US$ 80.000 a US$ 95.000 por ano no exterior. No Brasil, 
o uso específico de Lisp é raro e focado em nichos acadêmicos ou de IA, 
onde a remuneração depende do cargo geral de desenvolvimento (R$ 4.000 a R$ 16.000 mensais).
|#

#|
A família de linguagens Lisp é essencialmente multiparadigma. Embora tenha nascido historicamente ligada ao 
paradigma funcional (baseada no cálculo lambda e processamento de listas), os seus principais dialetos modernos 
(como o Common Lisp) incorporam e combinam diferentes formas de programar
|*
