#lang scribble/manual
@(require (for-label 2htdp/image))

@(require racket/sandbox
          scribble/example)

@(define my-evaluator
   (parameterize ([sandbox-output 'string]
                  [sandbox-error-output 'string]
                  [sandbox-memory-limit 50])
     (make-evaluator 'typed/racket/base)))

@(define pp-eval
   (let ()
     (my-evaluator '(require typed/picturing-programs))
     my-evaluator))

@title{Typed Picturing Programs}
@author{Andrew Mauer-Oats}

@table-of-contents[]

@section[#:tag "posn-util"]{Positions in the XY Plane}

@defmodule[typed/posn-util]

@defstruct[posn ([x Real] [y Real])]{
Position in the (x,y) plane. Straight from @racket[lang/posn].
}

@(examples
  #:eval pp-eval
  (define v (make-posn 5 12))
  (define w (make-posn 8 24))
  (define zero (make-posn 0 0))
)        

@defproc[(place-image/posn [img Image] [xy Posn] [background Image]) Image]{
Place the @racket[_img] at the (x,y) coordinates of @racket[_xy] on the @racket[_background].
}

@(examples #:eval pp-eval
           (place-image/posn (circle 40 "solid" "yellow")
                             (make-posn 60 80)
                             (rectangle 240 130 "solid" "lightgreen")))

@defproc[(add-posn [v Posn] [w Posn]) Posn]{
Add the corresponding coordinates of two posns.
}

@(examples
  #:eval pp-eval
  (add-posn (make-posn 5 12) (make-posn 8 24)))

@defproc[(sub-posn [v Posn] [w Posn]) Posn]{
Subtract the corresponding coordinates of two posns.
}

@(examples
  #:eval pp-eval
  (sub-posn (make-posn 8 24) (make-posn 5 15)))

@defproc[(scale-posn [k Real] [v Posn]) Posn]{
Multiply each of the coordinates of @racket[_v] by the real number @racket[_k].
}

@(examples
  #:eval pp-eval
  (scale-posn 2 (make-posn 5 12))
  (scale-posn 0.125 (make-posn 8 24)))

@defproc[(dist-squared-posn [v Posn] [w Posn]) Nonnegative-Real]{
Find the square of the distance between two positions. If the coordiates of each is an integer, this will result in an integer.
}

@(examples #:eval pp-eval
           (dist-squared-posn (make-posn 0 0) (make-posn 5 12))
           (dist-squared-posn (make-posn 0 0) (make-posn 8 24)))


@defproc*[([(dist-posn [v Posn] [w Posn]) Nonnegative-Real]
           [(distance [v Posn] [w Posn]) Nonnegative-Real])]{
Find the distance between two points (Posn).          
}

@(examples #:eval pp-eval
           (distance (make-posn 0 0) (make-posn 5 12))
           (distance (make-posn 3 20) (make-posn 11 44)))

@defproc[(posn=? [v Posn] [w Posn]) Boolean]{
True when corresponding coordinates (x's and y's) match exactly.
}                                             
 @section[#:tag "image"]{Image Transformation Functions}

@defmodule[typed/picturing-programs]

Readers of the Picturing Programs book by Stephen Bloch are comfortable with the
way images and check-expects work. When we start Typed Racket, they would prefer
that everything except types stay familiar. This package makes all of the Picturing
Programs code work in Typed Racket.

@defproc[(build-image [width Nonnegative-Integer]
                      [height Nonnegative-Integer]
                      [ f (Integer Integer -> Color )])
         Image ]{
Builds an image by evaluating the color function at every pixel.
}

@(examples
  #:eval pp-eval
  (define (f [x : Integer] [y : Integer ]) : Color
    (make-color (byte-clamp x)
                (byte-clamp (- 255 y))
                (byte-clamp (* 2 (+ x y)))))
  (build-image 255 200 f))


                     
