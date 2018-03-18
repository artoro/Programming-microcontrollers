	AL0 SET 51H	;pierwszy bajt liczby A
	AL1 SET 50H	;drugi bajt liczby A
	BL0 SET 53H	;pierwszy bajt liczby B
	BL1 SET 52H	;drugi bajt liczby B
	CL0 SET 55H	;pierwszy bajt liczby C (wynik dodawania)
	CL1 SET 54H	;drugi bajt liczby C
	
	SUM_A SET 60H
	SUM_B SET 61H
	SUM_C SET 62H
	
	LJMP START	;skok do programu glownego

;PROGRAM GLOWNY
	ORG 100H	;adres poczatku zapisu programu glownego
START:
	MOV AL0,#0FFH	;pierwszy bajt liczby A
	MOV AL1,#01H	;drugi bajt liczby A (A = 01FFH = 511)
	MOV BL0,#12H	;pierwszy bajt liczby B
	MOV BL1,#12H	;drugi bajt liczby B (B = 1212H = 4626)
	
	CLR C		;czyszczenie flagi
	MOV SUM_A,AL0	;argument A0
	MOV SUM_B,BL0	;argument B0
	CALL SUMA	;wywolanie procedury sumujacej dwie dwubajtowe liczby (A0 + B0 = C0)
	MOV CL0,SUM_C	;zapisanie pierwszego bajta wyniku do Cl0 (C0 = 11H + 100H = 273)
	
	MOV SUM_A,AL1	;argument A1
	MOV SUM_B,BL1	;argument B1
	CALL SUMA	;wywolanie procedury sumujacej dwie dwubajtowe liczby (A1 + B1 + CY = C1)
	MOV CL1,SUM_C	;zapisanie drugiego bajta wyniku do Cl1 (C1 = 14H = 20 -> C = 1411H = 5137)
	
KONIEC:
	LJMP START	;nieskonczona petla
	
;PROCEDURA SUMUJACA 2 LICZBY DWUBAJTOWE (A + B = C)
	ORG 200H	;adres poczatku zapisu procedury
SUMA:
	MOV A,SUM_A	;przepisanie do akumulatora liczby A
	ADDC A,SUM_B	;dodanie do akumulatora liczby B + CY
	MOV SUM_C,A	;zapisanie bajta wyniku do CL0
	RET		;powrot do programu glownego
	
END			;instrukcja preprocesora