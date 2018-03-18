	STOPER SET 20H ; flaga pracy stopera
	
	DPH0 SET 40H
	DPL0 SET 41H
	TH20 SET 42H
	TL20 SET 43H
	
	DPH1 SET 50H
	DPL1 SET 51H
	TH21 SET 52H
	TL21 SET 53H
	
	DPHd SET 60H
	DPLd SET 61H
	TH2d SET 62H
	TL2d SET 63H
	
	T2MOD SET 0C9H
	T2CON SET 0C8H
	TH2 SET 0CDH
	TL2 SET 0CCH
	RCAP2H SET 0CBH
	RCAP2L SET 0CAH
	
;///////////////////////////;

	LJMP INIT

	ORG 003H
	LJMP IN0
	
	ORG 02BH
	LJMP IRQT2

	ORG 50H
INIT:
	CLR STOPER ; wyzerowanie flagi
	MOV R7,#0 ; licznik petli glownej programu
	MOV P3,#0 ; port na ktorym nasluchujemy przerwan
	MOV R0,#0 ; licznik przycisku
	
	MOV TH2,#0D8H ; pamiec licznika T2
	MOV TL2,#0EFH
	MOV RCAP2H,TH2 ; wartosc startowa licznika T2
	MOV RCAP2L,TL2
	MOV T2MOD,#0
	MOV T2CON,#00000100B ; wlaczenie licznika T2
	
	MOV TMOD,#00001100B ; wlaczenie zewnetrznego przerwania INT0
	MOV TCON,#00000001B ; ustawienie zbocza opadajacego
	
	MOV IE,#0 ; wyzerowanie IE i ustawienie
	SETB IE.0 ; INT0
	SETB IE.5 ; T2
	SETB IE.7 ; wlaczenie obslugi przerwan
	LJMP MAIN
	
	ORG 100H
MAIN:
	INC R7
	LJMP MAIN
	
	ORG 200H
IRQT2:
	INC DPTR
	RETI
	
	ORG 250H
IN0:
	INC R0 ; zlicza przerwania z przycisku
	JB STOPER,STOP
START:
	MOV DPH0,DPH ; zapis wartosci
	MOV DPL0,DPL
	MOV TH20,TH2
	MOV TL20,TL2
	
	SETB STOPER ; wlaczenie flagi stopera
	LJMP ENDINT0
STOP:
	MOV DPH1,DPH ; zapis wartosci
	MOV DPL1,DPL
	MOV TH21,TH2
	MOV TL21,TL2
	
	CLR C
	MOV A,DPL1
	SUBB A,DPL0 ; DPLd = DPL1 - DPL0
	MOV DPLd,A
	MOV A,DPH1
	SUBB A,DPH0 ; DPHd = DPH1 - DPH0 - C
	MOV DPHd,A
	
	CLR C
	MOV A,TL21
	SUBB A,TL20 ; TL2d = TL21 - DTL20
	MOV TL2d,A
	MOV A,TH21
	SUBB A,TH20 ; TH2d = TH21 - TH20 - C
	MOV TH2d,A
	
	MOV TH2,RCAP2H ; ustawienie licznika na pozycji startowej (zerowanie)
	MOV TL2,RCAP2L
	CLR STOPER ; wylaczenie flagi stopera
ENDINT0:
	RETI
END