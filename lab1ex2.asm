; PROGRAM DODAJACY ZAWARTOSC P1 i P2
MOV P1,#2H	; wpisanie wartosci do portu P1 i nastepnie do P2
MOV P2,#3H
MOV A,P1	; wpisanie do akumulatora wartosci portu P1 (A = P1)
ADD A,P2	; dodanie do akumulatora wartosci portu P2 (A = A + P2 = P1 + P2)

; ZAPISANIE WYNIKU W PAMIECI RAM i XRAM
MOV 10H,A

MOV R1,#10H
MOV P2,#0H
MOVX @R1,A

; ZAKONCZENIE PROGRAMU
KONIEC: LJMP KONIEC
END