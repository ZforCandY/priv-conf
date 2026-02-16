#lang scheme
;;Goal:
;;English word/verse to piglatin[DONE]  ;(eachword with punctuation) to be implement..
;;Piglatin word/verse to english [TODO]

;;constant
(define CONSONANT
  '("B" "C" "D" "F" "G" "J" "K" "L" "M" "N" "P" "Q"
        "S" "T" "V" "X" "Z" "H" "R" "W" "Y"
        "b" "c" "d" "f" "g" "j" "k" "l" "m" "n" "p" "q"
        "s" "t" "v" "x" "z" "h" "r" "w" "y"))

(define VOWEL '("A" "E" "I" "O" "U"
                    "a" "e" "i" "i" "u"))

(define CONSONANT-CLUSTERS
  '("bl" "cl" "fl" "gl" "pl" "sl" "br" "cr" "dr" "fr"
         "gr" "pr" "tr" "sc" "sk" "sm" "sn" "sp" "st" "sw" "tw"
         "BL" "CL" "FL" "GL" "PL" "SL" "BR" "CR" "DR" "FR"
         "GR" "PR" "TR" "SC" "SK" "SM" "SN" "SP" "ST" "SW" "TW"
         "Bl" "Cl" "Fl" "Gl" "Pl" "Sl" "Br" "Cr" "Dr" "Fr"
         "Gr" "Pr" "Tr" "Sc" "Sk" "Sm" "Sn" "Sp" "St" "Sw" "Tw"))

(define PUNCTUATION
  '("." "~" "," "?" "!" "..." ":"))

;;functions
(define (get-first w)
  (if (string? w)
      (substring w 0 1)
      (substring(symbol->string w) 0 1)
      ))

;(get-first "hi")

(define (get-first-two w)
  (if (string? w)
      (substring w 0 2)
      (substring(symbol->string w) 0 2)
      ))

;  (get-first-two "hello")

(define (get-last w)
  (if (string? w)
      (substring w (- (string-length w)1) (string-length w))
      (substring(symbol->string w) (- (string-length w)1) (string-length w))
      ))

(define (word->piglatin s)
  (if (not(or(string? s) (symbol?  s)))
      'wrong-argument
      (if (string? s)
          (word->piglatin
           (string->symbol s))
          (if (member(get-first s)VOWEL)
             (string-append (symbol->string s) "-" (list-ref (list "way" "yay" "hay" "ay") (random 4)))
             (if (and(member(get-first s)CONSONANT)
                    (member(get-first-two s)CONSONANT-CLUSTERS))
                (string-downcase
                 (string-append
                  (substring
                   (symbol->string s)
                   2 (string-length(symbol->string s)))
                  "-"        (get-first-two s)
                  "ay"))
                (string-downcase
                 (string-append
                  (substring
                   (symbol->string s)
                   1 (string-length(symbol->string s)))
                  "-"        (get-first s)
                  "ay")))))))

;(word->piglatin "greek")
;;main-program
(define (string->piglatin s)
  (cond
    ((string=? s "")s)
    ((member (get-last s) PUNCTUATION)
     (append
      (map string->symbol
           (map word->piglatin
                (string-split
                 (substring s  0 (- (string-length s) 1))
                 )))
      (list(string->symbol(substring s  (- (string-length s) 1) (string-length s))))))
    (else (map string->symbol
               (map word->piglatin (string-split s))))))

;(string->piglatin "pig")
(string->piglatin
 "Their eyelids droop for want of sleep
  Greet the new guests and leave quickly.")

;(get-last "nig.")
