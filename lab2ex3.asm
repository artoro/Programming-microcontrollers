MOV R2,#5 ; wartosc poczatkowa licznika
MOV R1,#0
MOV A,R1

JZ F_END
FOR:
	INC R1
	DJNZ R2,FOR ; while (R2 > 0)
F_END: 	NOP

; ZAKONCZENIE PROGRAMU
KONIEC: SJMP KONIEC
END