 (import
   (utf8)
   (srfi-1)
   (utf8-srfi-13)
   (srfi-69))

(define string conc)
(define symbol string->symbol)
(define (length= l n) (= (length l) n))
(define (length> l n) (> (length l) n))
(define table make-hash-table)
(define put! hash-table-set!)
(define (has? table key) (hash-table-exists? table key))
(define (get table key . default) (hash-table-ref/default table key default))

; Stuff from "julia_extensions"
(load "julia-op-suffs.scm") ; Provides op-suffs
(define (strip-op-suffix op)
  (let* ((str-op (symbol->string op))
         (x (filter-map (lambda (suff)
                         (and (string-suffix? suff str-op)
                              (string-chomp str-op suff)))
                       op-suffs)))
    (string->symbol
     (if (null? x)
         str-op
         (car x)))))

(define (identifier-start-char? c)
  (cond ((or (and (char>=? c #\A)
                  (char<=? c #\Z))
             (and (char>=? c #\a)
                  (char<=? c #\z))
             (char=? c #\_))
         #t)
        ((or (char<? c #\uA1)
             (char>? c #\u10FFFF))
         #f)))

; Last line checked - 127
