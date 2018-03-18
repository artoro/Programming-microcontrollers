MOV R1,#0 ; wartosc poczatkowa licznika

CJNE R1,#5,WHILE
SJMP W_END 
WHILE:
	INC R1 ; R1++
	CJNE R1,#5,WHILE ; while (R1 != 5)
W_END: 	NOP

; ZAKONCZENIE PROGRAMU
KONIEC: SJMP KONIEC
END