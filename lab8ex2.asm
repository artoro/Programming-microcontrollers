; ------------------------------------------------------------------------- ;
; UWAGA: KLAWISZE W SYMULATORZE POWINNY BYC USTAWIONE TAK, JAK W INSTUKCJI! ;
; ------------------------------------------------------------------------- ;

; USTAWIENIE NAZW KOMOREK PAMIECI STANU KLAWISZY
	C0 SET 40H ; kolumna zerowa (najbardziej na lewo)
	C1 SET 41H ;	     pierwsza
	C2 SET 42H ;	     druga
	C3 SET 43H ;	     trzecia (najbardziej na prawo)

; PROGRAM
	LJMP INIT ; skok do inicjalizacji programu
	
	ORG 01BH
	LJMP TIN1 ; funkcja przerwania z licznika T1

; INICJALIZACJA PROGRAMU
	ORG 50H
INIT:
	MOV R5,#0 ; rejestr wywolan procedury KEYS
	MOV R6,#0 ; rejestr przejsc petli glownej
	MOV R7,#100D ; rejestr licznika przerwan
	CALL KEYS ; odczytanie poczatkowego stanu klawiszy i ustawienie portow przy uzyciu procedury KEYS
	
	; Konfiguracja licznika T1
	MOV IE,#0 ; wyzerowanie kontrolera przerwan
	MOV TH1,#055D ; bit starszy przepisywany do TL po przerwaniu
	MOV TL1,#055D ; bit mlodszy licznika T1 - zliczane jest 200 impulsow (przerwanie co 200 mikrosekund)
	MOV TMOD,#00100000B ; tryb pracy licznika M2 - timer 8 bitowy z wartoscia startowa
	MOV TCON,#01000000B ; wlaczenie pracy licznika
	SETB ET1 ; wlaczenie przerwan z licznika T1
	SETB EA ; wlaczenie obslugi przerwan
	
	LJMP MAIN ; skok do petli glownej programu

; NIESKONCZONA PETLA GLOWNA PROGRAMU
	ORG 100H
MAIN:
	INC R6 ; inkremenetacja licznika petli glownej (pokazuje, ze program sie wykonuje)
	LJMP MAIN
	
; FUNKCJA OBSLUGI PRZERWANIA
	ORG 200H	
TIN1:
	DJNZ R7,TIN1_END ; zliczane jest 100 przerwan, dzieki czemu stan klawiszy sprawdzany jest co 200us * 100 = 20 ms
	MOV R7,#100D ; ponowne ustawienie licznika
	CALL KEYS ; wywolanie procedury KEYS
TIN1_END:
	RETI ; powrot z przerwania do programu

; PROCEDURA ODCZYTANIA STANU KLAWISZY
KEYS:
	INC R5 ; zliczanie wywolan procedury
	MOV P2, #0FFH ; ustawienie poczatkowego stanu wysokiego portu P2
	MOV P1, #0FEH ; ustawienie bitu zerowego portu P1 w stan niski
	MOV C0, P2    ; odczytanie i zapis stanu lewej kolumny klawiszy (wartosci bitow od C0.0 do C0.3 odpowiadaja stanowi klawiszy zaczynajac od gory)
	MOV P2, #0FFH ; instrukcje odpowiadajace za odczytanie i zapis stanu kolejnych kolumn klawiszy
	MOV P1, #0FDH
	MOV C1, P2
	MOV P2, #0FFH
	MOV P1, #0FBH
	MOV C2, P2
	MOV P2, #0FFH
	MOV P1, #0F7H
	MOV C3, P2
	RET ; powrot z procedury
END