#lang info
(define collection 'multi) ;; important
(define deps '("base"
               "2htdp-typed"
               "picturing-programs"
               ; from 2htdp-typed:
               "draw-lib"
               "htdp-lib"
               "typed-racket-lib"
               "typed-racket-more"
               "unstable-list-lib"
               "unstable-contract-lib"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/picturing-programs-typed.scrbl" (multi-page))))
(define pkg-desc "(require typed/picturing-programs) to use Typed Racket with the Picturing Programs book.")
(define version "0.5")
(define pkg-authors '(maueroats))
