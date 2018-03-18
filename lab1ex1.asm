; ADRESOWANIE BEZPOSREDNIE
MOV A,#22H	; zapisuje w akumulatorze liczbe 22H (34 dziesietnie)
MOV R1,A 	; wpisuje do rejestru R1 zawartosc akumulatora
MOV 50H,A	; wpisuje do komorki pamieci RAM o adresie 50H zawartosc akumuatora
MOV P1,A	; wpisuje do portu P1 zawartosc akumulatora

; ADRESOWANIE POSREDNIE
MOV DPTR,#50H	; zapisuje w rejestrze 16-bitowym DPTR adres 50H
MOVX @DPTR,A	; wpisuje do komorki pamieci zewnetrznej XRAM o adresie zapisanym w DPTR wartosc z akumuatora

MOV R0,#51H	; zapisuje mlodszy bajt danych (adres 51H) w rejestrze R0
MOV P2,#0H	; zapisuje starszy bajt danych (adres 51H) w porcie P2
MOVX @R0,A	; wpisuje do komorki pamieci zewnetrznej XRAM o adresie zapisanym w R0 i P2 wartosc z akumuatora

; ZAKONCZENIE PROGRAMU
KONIEC: LJMP KONIEC ; nieskonczona petla konczaca program
END ; dyrektywa kompilatora informujaca o koncu programu