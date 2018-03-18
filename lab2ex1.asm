MOV R1,#0 ; wartosc poczatkowa licznika

DO:
	INC R1 ; R1++
	CJNE R1,#5,DO ; while (R1 != R2)
;END

; ZAKONCZENIE PROGRAMU
KONIEC: LJMP KONIEC
END