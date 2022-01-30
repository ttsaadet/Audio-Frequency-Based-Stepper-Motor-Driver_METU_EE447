

STCTRL		EQU		0xE000E010
STRELOAD	EQU		0xE000E014
STCURRENT	EQU		0xE000E018

				AREA	main, READONLY, CODE
				THUMB
				GET		address.s
				EXPORT	systic_init
				EXPORT	systic_handler
				EXTERN 	adc_init
				EXTERN	adc_read
		
;initialize systic interrupt
systic_init		PROC
				PUSH	{R4-R7}
				;disable systic					
				LDR		R5, =STCTRL
				MOV		R4, #0X00
				STR		R4, [R5]
				;genereate 2khz interrupt 
				MOV32	R4, #40000
				STR		R4, [R5, #4]
				STR		R4, [R5, #8]
				
				MOV		R4, #0X07 
				STR		R4, [R5] ;enable systic
	
				POP		{R4-R7}
				BX 		LR
				ENDP
					
systic_handler	PROC 
				ldr		r1, =STCTRL
				ldr		r0, [r1] ; read register to clear count flag
				ldr		r1, =ADC0_BASE
				ldr		r2, =ADCPSSI
				mov		r0, #0x04; seq2
				str		r0, [r1,r2]
				bx		lr
				ENDP


				END