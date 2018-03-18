;PROGRAM GLOWNY
	MOV SP, #20H	; ustawienie wierzcholka (poczatkowego adresu) stosu na adres #20H
	LJMP START	; skok do nieskonczoenj petli programu glownego
	ORG 100H	; procedura bedzie umieszczona w pamieci programu od adresu 100H
START:			; etykieta programu glownego
  ; Inicjalizacja
	MOV A, #0AH	; zainicjowanie akumulatora stala wartoscia #0AH = #10
	MOV DPTR, #0BH	; zainicjowanie dwubajtowego rejestru DPTR stala #0BH = #11
	MOV 50H, #0CH	; zainicjowanie komorki pamieci wewnetrznej z adresem 50H stala #0CH = #12
	MOV 51H, #0DH	; zainicjowanie komorki pamieci wewnetrznej z adresem 51H stala #0DH = #13
	
  ; Ustawienie banku BANK0 i wpis do rejestrow R1 i R2
	CLR RS1		; ustawienie banku BANK0 - bit starszy RS1 = 0,
	CLR RS0		;                          bit mlodszy RS2 = 0
	MOV R1, 50H	; wpisanie do rejestru R1 (BANK0) wartosci spod adresu 50H ( R1 = #0CH )
	MOV R2, 51H	; wpisanie do rejestru R2 (BANK0) wartosci spod adresu 51H ( R2 = #0DH )
	
	CALL TEST	; wywolanie procedury z etykieta TEST
	LJMP KONIEC	; skok do konca programu


;PROCEDURA TEST
	ORG 200H	; procedura bedzie umieszczona w pamieci programu od adresu 200H
TEST:			; etykieta procedury

  ; Zrzut pamieci operacyjnej na stos
	PUSH ACC	; zrzucenie na stos wartosci: akumulatora (kompilator podstawia pod ACC adres A),
	PUSH DPH	;                             starszego bajta rejestru DPTR,
	PUSH DPL	;                             mlodszego bajta rejestru DPTR,
	PUSH B		;                             rejestru pomocniczego B,
	PUSH PSW	;                             rejestru flag PSW
	
  ; Wpis do banku BANK1
	CLR RS1		; ustawienie banku BANK1 - bit starszy RS1 = 0,
	SETB RS0	;                          bit mlodszy RS0 = 1
	MOV R1, 50H	; wpisanie do rejestru R1 (BANK1) wartosci spod adresu 50H ( R1 = #0CH )
	MOV R2, 51H	; wpisanie do rejestru R2 (BANK1) wartosci spod adresu 51H ( R2 = #0DH )
	
  ; Negacja bitowa R1 i R2
	MOV A, R1	; przepisanie wartosci z rejestru R1 (BANK1) do akumulatora
	CPL A		; negacja bitowa akumulatora
	MOV R3, A	; wpisanie do rejestru R3 (BANK1) wartosci z akumulatora ( R3 = ~R1 = #F3H )
	MOV A, R2	; przepisanie wartosci z rejestru R2 (BANK1) do akumulatora
	CPL A		; negacja bitowa akumulatora
	MOV R4, A	; wpisanie do rejestru R4 (BANK1) wartosci z akumulatora ( R4 = ~R2 = #F2H )

  ; Iloczyn komorek 50H i 51H
	MOV A, 50H	; przepisanie wartosci z adresu 50H do akumulatora
	MOV B, 51H	; przepisanie wartosci z adresu 51H do rejestru pomocniczego B
	MUL AB		; mnozenie A * B i zapamietanie wyniku w A mlodszego i B starszego bajta ( BA = A*B = #009CH )
	SETB RS1	; ustawienie banku BANK2 - bit starszy RS1 = 1,
	CLR RS0		;                          bit mlodszy RS0 = 0
	MOV R1, B	; wpisanie do rejestru R1 (BANK2) wartosci z rejestru B ( R1 = B = #00H )
	MOV R2, A	; wpisanie do rejestru R2 (BANK2) wartosci z akumulatora ( R1 = B = #9CH )

  ; Przelaczenie banku na BANK0 i przywrocenie wartosci ze stosu
	CLR RS1		; ustawienie banku BANK0 - bit starszy RS1 = 0,
	CLR RS0		;                          bit mlodszy RS0 = 0
	POP PSW		; przepisanie za stosu wartosci: rejestru flag PSW, 
	POP B		;                                rejestru pomocniczego B,
	POP DPL		;                                mlodszego bajta rejestru DPTR,
	POP DPH		;                                starszego bajta rejestru DPTR,
	POP ACC		;                                akumulatora
	RET		; instrukcja konca procedury i powrotu do miejsca jej wywolania zapisanego na stosie

; ZAKONCZENIE PROGRAMU
KONIEC:
	SJMP KONIEC	; nieskonczona petla konczaca program
	END 		; dyrektywa kompilatora informujaca o koncu programu