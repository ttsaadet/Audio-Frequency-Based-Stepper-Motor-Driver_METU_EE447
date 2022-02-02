

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
		EXTERN  led_pwm_write
		EXTERN turnOffTimer
		EXTERN	delay1s	
		EXTERN 	clock_configure
		;varaible pointer extern; 
		EXTERN	arm_cfft_sR_q15_len256
		
		EXTERN	CNVRT
		EXTERN	OutStr
		
		
		EXPORT 	__main
			
__main	PROC
		;BL		clock_configure
		BL		adc_init
		BL		led_init
		;BL		stepper_sw_init
		;BL		stepper_out_init
		
		BL		systic_init
		;BL		stepper_timer2_init
		
		MOV		R7, #0
		
start	CMP		R10, #1
		BNE		start
		MOV		R10, #0
		
		
		ldr		R1, =STCTRL
		ldr		r0, [r1]
		bic		r0, #0x1
		str		r0, [r1]
		LDR		R0, =arm_cfft_sR_q15_len256
		LDR		R1,	=MIC_SAMPLE_DATA_ADDR
		MOV		R2, #0
		MOV		R3, #1
		BL		arm_cfft_q15
		BL		findMax
		
		
		ldr		R1, =STCTRL
		ldr		r0, [r1]
		orr		r0, #0x1
		str		r0, [r1]
		;LDR		R1, =AMP_TH_ADDR_POT3
		;LDR		R0, [R1]
		
		BL	AdjustLeds

		;CMP		R2, R1 ;IF MAX AMP > AMP TH THEN TURN ON LEDS
;		BLHS	turnOnLeds
		;BLHS	confStepper
		
		B		start
		ENDP
			
			
			
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;findMax; @param: none, @return r5 = max amplitude ,r6 = (dom freq)
findMax	PROC
		PUSH	{R0-R4,R7, R10,R9}
		ldr		r1, =MIC_SAMPLE_DATA_ADDR
		mov		R0, #0
		mov		R2, #0
		mov		r5 ,#0
		mov		r6, #0

_start	ADD		R7, #1
		
		CMP		R7, #128
		BEQ		_done
		LDR		R0, [R1,R2]
		ADD		R2, #4
		LDR		R8, =0xffff;
		AND		R8, R0     ;real part
		SMULBB	R3, R8, R8 ;r3: real^2 
		LSR		R9, R0, #16; imaginarty part
		SMULBB	R4, R9, R9; 
		ADD		R3, R4 ;R3: =  R3: reel^2, r4: im^2
		CMP		R3, R5
		MOVHS	R5,	R3	;if read > prev read then update max value
		MOVHS	R6, R7	;if read > prev read then update max index
		
		B		_start
_done	LDR		R1, =2000 ;2000 sampling frequency
		MUL		R6,R1    ;
		LDR		R1, =256
		UDIV	R6,R1	;R6 HOLDS FREKANS
		LSR		R5, #10 ;magnitude
		POP		{R0-R4,R7, R8,R9}
		BX		LR
		ENDP
			
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;turnOnLeds @param r5: amplitude, r6, frekans 
AdjustLeds	PROC
			PUSH	{R0-R3,LR}
		
			MOV		R0, #500
			CMP		R0, R5 
			BHS		_turnoff
			MOV		R0, #250; LOW FREQ 
			CMP		R6, R0
			BHS		_higher ;higher than low th
			BLS		_lower
_lower		MOV		R0, #0 ;SELECET RED
			LSL		R5, #3
			BL		led_pwm_write
			B		_doneLed

_higher		MOV		R0, #600 ; HIGH GREQ
			CMP		R6, R0
			BLS		_inBetween
			MOV		R0, #2 ; SLECET BLUE
			LSL		R5, #3
			BL		led_pwm_write
			B		_doneLed
_inBetween	
			MOV		R0, #1	; SELECT GREEN
			LSL		R5, #3
			BL		led_pwm_write
			B		_doneLed
_turnoff	LDR		R1, =TIMER0
			MOV		R0,	#1 ;timer0 b off
			BL		turnOffTimer
			LDR		R1, =TIMER1
			MOV		R0,	#0 ;timer1 a off
			BL		turnOffTimer
			LDR		R1, =TIMER1
			MOV		R0,	#1 ;timer1 b off
			BL		turnOffTimer
_doneLed	POP		{R0-R3,LR}
			BX		LR
			ENDP
				

			END