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
; (1) RULE ask-mean-concave-points (Untuk menghandle mean concave points)
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
; (2) RULE ask-worst-radius (Untuk menghandle worst radius)
;=================================================================
(defrule ask-worst-radius
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
; (3) RULE ask-worst-perimeter (Untuk menghandle worst perimeter)
;=================================================================
(defrule ask-worst-perimeter
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
; (4) RULE ask-radius-error (Untuk menghandle radius error)
;=================================================================
(defrule ask-radius-error
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
; (5) RULE ask-mean-texture-1 (Untuk menghandle mean texture 1 jalur worst radius)
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
; (6) RULE ask-worst-texture-1 (Untuk menghandle worst texture 1 jalur worst perimeter)
;=================================================================
(defrule ask-worst-texture-1
    ?ask <- (ask worst_texture_1)
=>
    (printout t "worst_texture? ")
    (retract ?ask)
    (assert (worst_texture_1 (read))))

(defrule leq-input-wt1
    ?input <- (worst_texture_1 ?wt1&:(numberp ?wt1)
                             &:(<= ?wt1 25.65))
=>
    (retract ?input)
    (assert (ask worst_concave_points)))

(defrule gt-input-wt1
    ?input <- (worst_texture_1 ?wt1&:(numberp ?wt1)
                             &:(> ?wt1 25.65))
=>
    (retract ?input)
    (assert (ask perimeter_error)))

(defrule bad-input-wt1
    ?input <- (worst_texture_1 ?wt1)
    (not (numberp ?wt1))
=>
    (retract ?input)
    (printout t "Your input is not valid :( " crlf)
    (assert (ask worst_texture_1)))

;=================================================================
; (7) RULE ask-worst-texture-2 (Untuk menghandle worst texture 2 jalur radius error)
;=================================================================
(defrule ask-worst-texture-2
    ?ask <- (ask worst_texture_2)
=>
    (printout t "worst_texture? ")
    (retract ?ask)
    (assert (worst_texture_2 (read))))

(defrule leq-input-wt2
    ?input <- (worst_texture_2 ?wt2&:(numberp ?wt2)
                             &:(<= ?wt2 30.15))
=>
    (retract ?input)
    (assert (conclusion 1)))

(defrule gt-input-wt2
    ?input <- (worst_texture_2 ?wt2&:(numberp ?wt2)
                             &:(> ?wt2 30.15))
=>
    (retract ?input)
    (assert (ask worst_area)))

(defrule bad-input-wt2
    ?input <- (worst_texture_2 ?wt2)
    (not (numberp ?wt2))
=>
    (retract ?input)
    (printout t "Your input is not valid :( " crlf)
    (assert (ask worst_texture_2)))

;=================================================================
; (8) RULE ask-mean-smoothness (Untuk menghandle mean smoothness)
;=================================================================
(defrule ask-mean-smoothness
    ?ask <- (ask mean_smoothness)
=>
    (printout t "mean_smoothness? ")
    (retract ?ask)
    (assert (mean_smoothness (read))))

(defrule leq-input-ms
    ?input <- (mean_smoothness ?ms&:(numberp ?ms)
                             &:(<= ?ms 0.09))
=>
    (retract ?input)
    (assert (conclusion 1)))

(defrule gt-input-ms
    ?input <- (mean_smoothness ?ms&:(numberp ?ms)
                             &:(> ?ms 0.09))
=>
    (retract ?input)
    (assert (conclusion 0)))

(defrule bad-input-ms
    ?input <- (mean_smoothness ?ms)
    (not (numberp ?ms))
=>
    (retract ?input)
    (printout t "Your input is not valid :( " crlf)
    (assert (ask mean_smoothness)))

;=================================================================
; (9) RULE concave-points-error (Untuk menghandle concave points error)
;=================================================================
(defrule ask-concave-points-error
    ?ask <- (ask concave_points_error)
=>
    (printout t "concave_points_error? ")
    (retract ?ask)
    (assert (concave_points_error (read))))

(defrule leq-input-cpe
    ?input <- (concave_points_error ?cpe&:(numberp ?cpe)
                             &:(<= ?cpe 0.01))
=>
    (retract ?input)
    (assert (conclusion 0)))

(defrule gt-input-cpe
    ?input <- (concave_points_error ?cpe&:(numberp ?cpe)
                             &:(> ?cpe 0.01))
=>
    (retract ?input)
    (assert (conclusion 1)))

(defrule bad-input-cpe
    ?input <- (concave_points_error ?cpe)
    (not (numberp ?cpe))
=>
    (retract ?input)
    (printout t "Your input is not valid :( " crlf)
    (assert (ask concave_points_error)))

;=================================================================
; (10) RULE worst-concave-points (Untuk menghandle worst concave points)
;=================================================================
(defrule ask-worst-concave-points
    ?ask <- (ask worst_concave_points)
=>
    (printout t "worst_concave_points? ")
    (retract ?ask)
    (assert (worst_concave_points (read))))

(defrule leq-input-wcp
    ?input <- (worst_concave_points ?wcp&:(numberp ?wcp)
                             &:(<= ?wcp 0.17))
=>
    (retract ?input)
    (assert (conclusion 1)))

(defrule gt-input-wcp
    ?input <- (worst_concave_points ?wcp&:(numberp ?wcp)
                             &:(> ?wcp 0.17))
=>
    (retract ?input)
    (assert (conclusion 0)))

(defrule bad-input-wcp
    ?input <- (worst_concave_points ?wcp)
    (not (numberp ?wcp))
=>
    (retract ?input)
    (printout t "Your input is not valid :( " crlf)
    (assert (ask worst_concave_points)))

;=================================================================
; (11) RULE ask-perimeter-error (Untuk menghandle perimeter error)
;=================================================================
(defrule ask-perimeter-error
    ?ask <- (ask perimeter_error)
=>
    (printout t "perimeter_error? ")
    (retract ?ask)
    (assert (perimeter_error (read))))

(defrule leq-input-pe
    ?input <- (perimeter_error ?pe&:(numberp ?pe)
                             &:(<= ?pe 1.56))
=>
    (retract ?input)
    (assert (ask mean_radius_1)))

(defrule gt-input-pe
    ?input <- (perimeter_error ?pe&:(numberp ?pe)
                             &:(> ?pe 1.56))
=>
    (retract ?input)
    (assert (conclusion 0)))

(defrule bad-input-pe
    ?input <- (perimeter_error ?pe)
    (not (numberp ?pe))
=>
    (retract ?input)
    (printout t "Your input is not valid :( " crlf)
    (assert (ask perimeter_error)))

;=================================================================
; (12) RULE ask-worst-area (Untuk menghandle worst area)
;=================================================================
(defrule ask-worst-area
    ?ask <- (ask worst_area)
=>
    (printout t "worst_area? ")
    (retract ?ask)
    (assert (worst_area (read))))

(defrule leq-input-wa
    ?input <- (worst_area ?wa&:(numberp ?wa)
                             &:(<= ?wa 641.60))
=>
    (retract ?input)
    (assert (conclusion 1)))

(defrule gt-input-wa
    ?input <- (worst_area ?wa&:(numberp ?wa)
                             &:(> ?wa 641.60))
=>
    (retract ?input)
    (assert (ask mean_radius_2)))

(defrule bad-input-wa
    ?input <- (worst_area ?wa)
    (not (numberp ?wa))
=>
    (retract ?input)
    (printout t "Your input is not valid :( " crlf)
    (assert (ask worst_area)))

;=================================================================
; (13) RULE ask-mean-radius-1 (Untuk menghandle mean radius 1 jalur perimeter error)
;=================================================================
(defrule ask-mean-radius-1
    ?ask <- (ask mean_radius_1)
=>
    (printout t "mean_radius? ")
    (retract ?ask)
    (assert (mean_radius_1 (read))))

(defrule leq-input-mr1
    ?input <- (mean_radius_1 ?mr1&:(numberp ?mr1)
                             &:(<= ?mr1 13.34))
=>
    (retract ?input)
    (assert (conclusion 0)))

(defrule gt-input-mr1
    ?input <- (mean_radius_1 ?mr1&:(numberp ?mr1)
                             &:(> ?mr1 13.34))
=>
    (retract ?input)
    (assert (conclusion 1)))

(defrule bad-input-mr1
    ?input <- (mean_radius_1 ?mr1)
    (not (numberp ?mr1))
=>
    (retract ?input)
    (printout t "Your input is not valid :( " crlf)
    (assert (ask mean_radius_1)))

;=================================================================
; (14) RULE ask-mean-radius-2 (Untuk menghandle mean radius 2 jalur worst area)
;=================================================================
(defrule ask-mean-radius-2
    ?ask <- (ask mean_radius_2)
=>
    (printout t "mean_radius? ")
    (retract ?ask)
    (assert (mean_radius_2 (read))))

(defrule leq-input-mr2
    ?input <- (mean_radius_2 ?mr2&:(numberp ?mr2)
                             &:(<= ?mr2 13.45))
=>
    (retract ?input)
    (assert (ask mean_texture_2)))

(defrule gt-input-mr2
    ?input <- (mean_radius_2 ?mr2&:(numberp ?mr2)
                             &:(> ?mr2 13.45))
=>
    (retract ?input)
    (assert (conclusion 1)))

(defrule bad-input-mr2
    ?input <- (mean_radius_2 ?mr2)
    (not (numberp ?mr2))
=>
    (retract ?input)
    (printout t "Your input is not valid :( " crlf)
    (assert (ask mean_radius_2)))

;=================================================================
; (15) RULE ask-mean-texture-2 (Untuk menghandle mean texture 2 jalur mean radius)
;=================================================================
(defrule ask-mean-texture-2
    ?ask <- (ask mean_texture_2)
=>
    (printout t "mean_texture? ")
    (retract ?ask)
    (assert (mean_texture_2 (read))))

(defrule leq-input-mt2
    ?input <- (mean_texture_2 ?mt2&:(numberp ?mt2)
                             &:(<= ?mt2 28.79))
=>
    (retract ?input)
    (assert (conclusion 0)))

(defrule gt-input-mt2
    ?input <- (mean_texture_2 ?mt2&:(numberp ?mt2)
                             &:(> ?mt2 28.79))
=>
    (retract ?input)
    (assert (conclusion 1)))

(defrule bad-input-mt2
    ?input <- (mean_texture_2 ?mt2)
    (not (numberp ?mt2))
=>
    (retract ?input)
    (printout t "Your input is not valid :( " crlf)
    (assert (ask mean_texture_2)))

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