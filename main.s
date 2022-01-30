AMP_THRESH_ADDR  EQU  0x20000900
FREQUENCY_THRESH_ADDR	EQU	0x20000904 ;high two byte high frq th, low two byte holds low freq th
	

		AREA 	main, CODE, READONLY
		THUMB
		;subroutine extern 
		GET		address.s
		EXTERN	systic_init
		EXTERN	adc_init
		EXTERN	arm_cfft_q15
		EXTERN 	stepper_sw_init
		EXTERN 	stepper_out_init
		EXTERN	stepper_timer2_init
		EXTERN	stepper_timer2_setSpeed
		;
		EXTERN  led_init
		EXTERN	pwm_write
		EXTERN	delay1s	
		EXTERN 	clock_configure
		;varaible pointer extern; 
		EXTERN	arm_cfft_sR_q15_len256
		
		
		EXPORT 	__main
			
__main	PROC
		BL		clock_configure
		BL		adc_init
		BL		led_init
		BL		stepper_sw_init
		BL		stepper_out_init
		
		BL		systic_init
		BL		stepper_timer2_init
		
		MOV		R7, #0
		
start	CMP		R10, #1
		BNE		start
		MOV		R10, #0
		
		
		LDR		R0, =arm_cfft_sR_q15_len256
		LDR		R1,	=MIC_SAMPLE_DATA_ADDR
		MOV		R2, #0
		MOV		R3, #0
		BL		arm_cfft_q15
		BL		findMax
;		LDR		R1, =AMP_THRESH_ADDR
;		CMP		R2, R1 ;IF MAX AMP > AMP TH THEN TURN ON LEDS
;		BLHS	turnOnLeds
		;BLHS	confStepper
		B		start
		ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;findMax; @param R1 data start address , @return r2 = max amplitude ,r3 = (dom freq)
findMax	PROC
		PUSH	{R0,R1,R5, R6}
		ldr		r1, =MIC_SAMPLE_DATA_ADDR
		mov		R0, #0
		mov		R2, #0
		mov		r6, #0
_start	ADD		R6, #1
		
		CMP		R0, #0x200
		BEQ		_done
		LDR		R5, [R1,R0]
		ADD		R0, #4
		LDR		R7, =0xffff;
		AND		R7,	R5;real part
		MUL		R7, R7
		LSR		R8, R5, #16; imaginarty part
		MUL		R8, R8; 
		ADD		R5, R7,R8 ;R5 MAGNITUDE
		CMP		R5, R2
		MOVHS	R2,	R5	;if read > prev read then update max value
		MOVHS	R3, R6	;if read > prev read then update max index
		
		B		_start
_done	LDR		R1, =2000 ;2000 sampling frequency
		MUL		R3,R1    ;
		LDR		R1, =256
		UDIV	R3,R1	;R3 HOLDS FREKANS
				POP		{R0,R1,R5, R6}
		BX		LR
		ENDP
			
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;turnOnLeds @param r1: frequency
turnOnLeds	PROC
			PUSH	{R0-R3}
			LDR		R0,=FREQUENCY_THRESH_ADDR
			LDR		R2, [R0]
			LDR		R0, =0xffff
			AND		R3, R2, R0 ;r3 low freq th
			LSR		R2, #16	;r2 high freq th
			CMP		R1, R3
			BHS		_higher ;higher than low th
			BLS		_lower
_lower		;todo 	turn on red
			B		_doneLed
_higher		CMP		R1, R2
			BLS		_inBetween
			;todo  	turn on blue
			B		_doneLed
_inBetween	;todo 	turn on green
			B		_doneLed
_doneLed	POP		{R0-R3}
			BX		LR
			ENDP
				

			END