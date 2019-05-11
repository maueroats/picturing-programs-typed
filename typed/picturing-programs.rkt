#lang typed/racket
; Version 0.8 written 2019-05-09.
(require typed/lang/posn)
(require typed/2htdp/image)
(require typed/2htdp/universe)
(require typed/test-engine/racket-tests)
(require "posn-util.rkt")

(define-type Build3-Image-Func (Natural Natural -> Natural))
(define-type Map3-Image-Func (Natural Natural Natural Natural Natural -> Natural))

; byte-clamp is tricky for students to write because the constant has to be in the first
; position for the type checker to figure out the correct limits on the time (as of Racket 7.2)
(define (byte-clamp [n : Integer])
  : Byte
  (min 255 (max 0 n)))
(provide byte-clamp)

(define (byte-clamp-f [f : Build3-Image-Func])
  : (Natural Natural -> Byte)
  (lambda ([x : Natural] [y : Natural]) : Byte
    (byte-clamp (f x y))))

(provide (all-from-out typed/lang/posn
                       typed/2htdp/image
                       typed/2htdp/universe
                       typed/test-engine/racket-tests
                       "posn-util.rkt"
                       ))

(require/typed/provide picturing-programs
                       [real->int (Real -> Integer)]
                       [name->color (String -> (U Color False))]
                       [colorize (Image-Color -> Color)]
                       [get-pixel-color (Nonnegative-Integer Nonnegative-Integer Image -> Color)]
                       [color=? (Color Color -> Boolean)]
                       [build-image
                        (Natural Natural (Natural Natural -> Image-Color)
                                 -> Image)]
                       [build-image/extra
                        (Natural Natural (Natural Natural Any -> Image-Color) Any
                                 -> Image)]
                       [build3-image
                        (Natural Natural Build3-Image-Func Build3-Image-Func Build3-Image-Func
                                 -> Image)]
                       [build4-image
                        (Natural Natural Build3-Image-Func Build3-Image-Func Build3-Image-Func Build3-Image-Func
                                 -> Image)]
                       [map-image ((U (Color -> Image-Color)
                                      (Natural Natural Color -> Image-Color))
                                   Image
                                   -> Image)]
                       [map-image/extra ((U (Color Any -> Image-Color)
                                            (Natural Natural Color Any -> Image-Color))
                                         Image
                                         Any
                                         -> Image)]
                       [map3-image (Map3-Image-Func Map3-Image-Func Map3-Image-Func Image
                                                    -> Image)]
                       [fold-image (All (X)
                                        ((U (Color X -> X)
                                            (Natural Natural Color X -> X))
                                         X
                                         Image
                                         -> X))]
                       [fold-image/extra (All (X Y-Extra)
                                              ((U (Color X Y-Extra -> X)
                                                  (Natural Natural Color X Y-Extra -> X))
                                               X
                                               Image
                                               Y-Extra
                                               -> X))]
                       )


