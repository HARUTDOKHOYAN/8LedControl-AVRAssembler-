.include "m16def.inc"
.include "delayRRR.inc"
.CSEG
.org $00


.def Mask = R18 ;Mask reg
.def Counter = R17 ;hashvich
.def temp = R16
.equ Start = 0 

	
	 jmp main

	 .org $2A
main: 

					 					;Stack Forwarding	 
	 ldi		temp,low(RAMEND)
	 out		SPL,temp			
	 ldi		temp,high(RAMEND)
	 out		SPH,temp
					 					;PORTC 0-7 Output Pin (DDRC = $FF , PORTC = $FF)

 	 ser temp        					;DDRC Register set all byts 0xFF
	 out DDRC, temp

	 ser temp		 					;PORTC Register set all byts 0xFF
	 out PORTC, temp

	 cbi DDRD , Start
	 sbi PORTD , Start


AGN:
	 clc
	 ldi temp , $FF
	 ldi Mask , $FF
	 ldi Counter , $08
ZERO:	  
	 sbic PIND , Start 
	 jmp ZERO

	 ROL Mask
	 out PORTC , Mask
	 delay  $2A,$B7,$AC
	 
	 out PORTC , temp
	 dec Counter
	 brne  ZERO
	 jmp AGN
