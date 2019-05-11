#lang typed/racket
(require typed/lang/posn)
(require typed/2htdp/image)

(provide (all-defined-out))

(: add-posn (-> Posn Posn Posn))
(define (add-posn a b)
  (make-posn (+ (posn-x a) (posn-x b))
             (+ (posn-y a) (posn-y b))))

(: scale-posn (-> Real Posn Posn))
(define (scale-posn k v)
  (make-posn (* k (posn-x v))
             (* k (posn-y v))))

(: sub-posn (-> Posn Posn Posn))
(define (sub-posn a b)
  (add-posn a (scale-posn -1 b)))

(: norm (-> Posn Nonnegative-Real))
(define (norm a)
  (+ (sqr (posn-x a))
     (sqr (posn-y a))))

(: dist-squared-posn (-> Posn Posn Nonnegative-Real))
(define (dist-squared-posn a b)
  (norm (sub-posn a b)))

(: dist-posn (-> Posn Posn Nonnegative-Real))
(define (dist-posn a b)
  (sqrt (dist-squared-posn a b)))

(: distance (-> Posn Posn Nonnegative-Real))
(define (distance p q)
  (sqrt (+ (sqr (- (posn-x p)
                   (posn-x q)))
           (sqr (- (posn-y p)
                   (posn-y q))))))

(: place-image/posn (-> Image Posn Image Image))
(define (place-image/posn img p bg)
  (place-image img
               (posn-x p)
               (posn-y p)
               bg))

(: add-posns (-> Posn Posn Posn))
(define (add-posns p1 p2)
  (add-posn p1 p2))

(: sub-posns (-> Posn Posn Posn))
(define (sub-posns p1 p2)
  (sub-posn p1 p2))

(: posn=? (-> Posn Posn Boolean))
(define (posn=? p q)
  (and (= (posn-x p) (posn-x q))
       (= (posn-y p) (posn-y q))))

          
