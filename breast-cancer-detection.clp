;=================================================================
; Kelompok: AIzy
; Anggota: Epata Tuah (13519120), Prana Gusriana (13519195)
; File: breast-cancer-detection.clp
; Date: 11 November 2021
; Description: Rule based system untuk mendeteksi kanker payudara
;=================================================================

;=================================================================
; RULE start-up (Untuk memulai aplikasi)
;=================================================================
(defrule start-up
    (initial-fact)
=>
    (assert (ask mean_concave_points)))

;=================================================================
; RULE ask-mean-concave-points (Untuk menghandle mean concave points)
;=================================================================
(defrule ask-mean-concave-points
    ?ask <- (ask mean_concave_points)
=>
    (printout t "mean_concave_points? ")
    (retract ?ask)
    (assert (mean_concave_points (read))))

(defrule leq-input-mcp
    ?input <- (mean_concave_points ?mcp&:(numberp ?mcp)
                             &:(<= ?mcp 0.05))
=>
    (retract ?input)
    (assert (ask worst_radius)))

(defrule gt-input-mcp
    ?input <- (mean_concave_points ?mcp&:(numberp ?mcp)
                             &:(> ?mcp 0.05))
=>
    (retract ?input)
    (assert (ask worst_perimeter)))

(defrule bad-input-mcp
    ?input <- (mean_concave_points ?mcp)
    (not (numberp ?mcp))
=>
    (retract ?input)
    (printout t "Your input is not valid :( " crlf)
    (assert (ask mean_concave_points)))

;=================================================================
; RULE ask-worst-radius (Untuk menghandle worst radius)
;=================================================================
(defrule worst-radius
    ?ask <- (ask worst_radius)
=>
    (printout t "worst_radius? ")
    (retract ?ask)
    (assert (worst_radius (read))))

(defrule leq-input-wr
    ?input <- (worst_radius ?wr&:(numberp ?wr)
                             &:(<= ?wr 16.83))
=>
    (retract ?input)
    (assert (ask radius_error)))

(defrule gt-input-wr
    ?input <- (worst_radius ?wr&:(numberp ?wr)
                             &:(> ?wr 16.83))
=>
    (retract ?input)
    (assert (ask mean_texture_1)))

(defrule bad-input-wr
    ?input <- (worst_radius ?wr)
    (not (numberp ?wr))
=>
    (retract ?input)
    (printout t "Your input is not valid :( " crlf)
    (assert (ask worst_radius)))

;=================================================================
; RULE ask-radius-error (Untuk menghandle radius error)
;=================================================================
(defrule radius-error
    ?ask <- (ask radius_error)
=>
    (printout t "radius_error? ")
    (retract ?ask)
    (assert (radius_error (read))))

(defrule leq-input-re
    ?input <- (radius_error ?re&:(numberp ?re)
                             &:(<= ?re 0.63))
=>
    (retract ?input)
    (assert (ask worst_texture_2)))

(defrule gt-input-re
    ?input <- (radius_error ?re&:(numberp ?re)
                             &:(> ?re 0.63))
=>
    (retract ?input)
    (assert (ask mean_smoothness)))

(defrule bad-input-re
    ?input <- (worst_radius ?re)
    (not (numberp ?re))
=>
    (retract ?input)
    (printout t "Your input is not valid :( " crlf)
    (assert (ask radius_error)))

;=================================================================
; RULE ask-worst-perimeter (Untuk menghandle worst perimeter)
;=================================================================
(defrule worst-perimeter
    ?ask <- (ask worst_perimeter)
=>
    (printout t "worst_perimeter? ")
    (retract ?ask)
    (assert (worst_perimeter (read))))

(defrule leq-input-wp
    ?input <- (worst_perimeter ?wp&:(numberp ?wp)
                             &:(<= ?wp 114.45))
=>
    (retract ?input)
    (assert (ask worst_texture_1)))

(defrule gt-input-wp
    ?input <- (worst_perimeter ?wp&:(numberp ?wp)
                             &:(> ?wp 114.45))
=>
    (retract ?input)
    (assert (conclusion 0)))

(defrule bad-input-wp
    ?input <- (worst_perimeter ?wp)
    (not (numberp ?wp))
=>
    (retract ?input)
    (printout t "Your input is not valid :( " crlf)
    (assert (ask worst_perimeter)))

;=================================================================
; RULE ask-mean-texture-1 (Untuk menghandle mean texture 1)
;=================================================================
(defrule ask-mean-texture-1
    ?ask <- (ask mean_texture_1)
=>
    (printout t "mean_texture? ")
    (retract ?ask)
    (assert (mean_texture_1 (read))))

(defrule leq-input-mt1
    ?input <- (mean_texture_1 ?mt1&:(numberp ?mt1)
                             &:(<= ?mt1 16.19))
=>
    (retract ?input)
    (assert (conclusion 1)))

(defrule gt-input-mt1
    ?input <- (mean_texture_1 ?mt1&:(numberp ?mt1)
                             &:(> ?mt1 16.19))
=>
    (retract ?input)
    (assert (ask concave_points_error)))

(defrule bad-input-mt1
    ?input <- (mean_texture_1 ?mt1)
    (not (numberp ?mt1))
=>
    (retract ?input)
    (printout t "Your input is not valid :( " crlf)
    (assert (ask mean_texture_1)))

;=================================================================
; RULE conclusion
;=================================================================
(defrule conclusion-breast-cancer
    (conclusion 1)
=>
    (printout t "Hasil Prediksi = Terprediksi Kanker Payudara :(" crlf))

(defrule conclusion-not-breast-cancer
    (conclusion 0)
=>
    (printout t "Hasil Prediksi = Tidak Terprediksi Kanker Payudara \\(^v^)/" crlf))