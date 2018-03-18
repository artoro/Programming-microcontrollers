AL0 SET 51H	;pierwszy bajt liczby A
AL1 SET 50H	;drugi bajt liczby A
BL0 SET 53H	;pierwszy bajt liczby B
BL1 SET 52H	;drugi bajt liczby B
CL0 SET 55H	;pierwszy bajt liczby C (wynik dodawania)
CL1 SET 54H	;drugi bajt liczby C

LJMP START	;skok do programu glownego

;PROGRAM GLOWNY
ORG 100H	;adres poczatku zapisu programu glownego
START:
MOV AL0,#0FFH	;pierwszy bajt liczby A
MOV AL1,#01H	;drugi bajt liczby A (A = 01FFH = 511)
MOV BL0,#12H	;pierwszy bajt liczby B
MOV BL1,#12H	;drugi bajt liczby B (B = 1212H = 4626)
CALL SUMA	;wywolanie procedury sumujacej dwie dwubajtowe liczby (A + B = C)
MOV R1,CL0	;przeniesienie pierwszego bajta wyniku do rejestru R1
MOV P2,CL1	;przeniesienie drugiego bajta wyniku do portu P2 (C = 1411H = 5137)
KONIEC:
LJMP START	;nieskonczona petla

;PROCEDURA SUMUJACA 2 LICZBY DWUBAJTOWE (A + B = C)
ORG 200H	;adres poczatku zapisu procedury
SUMA:
CLR C  ;zerowanie bitu flagi przeniesienia
MOV A,AL0	;przepisanie do akumulatora pierwszego bajta liczby A
ADD A,BL0	;dodanie do akumulatora pierwszego bajta liczby B
MOV CL0,A	;zapisanie pierwszego bajta wyniku do CL0

MOV A,AL1	;przepisanie do akumulatora drugiego bajta liczby A
ADDC A,BL1	;dodanie do akumulatora drugiego bajta liczby B
MOV CL1,A	;zapisanie drugiego bajta wyniku do CL1
RET  ;powrot do programu glownego

END  ;instrukcja preprocesora