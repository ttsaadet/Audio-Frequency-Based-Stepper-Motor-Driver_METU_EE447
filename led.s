
			AREA	routines, CODE, READONLY
			THUMB
			GET		address.s
			EXPORT	led_init
			EXPORT	led_pwm_write
			EXPORT 	turnOffTimer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;default gpio output initilization for f1,f2,f3
led_init	PROC
			PUSH	{R0-R3}
			PUSH	{LR}
			BL		led_timer_pwm_init
			POP		{LR}
			LDR		R1, =RCGCGPIO
			LDR		R0, [R1]
			ORR		R0, #0x20
			STR		R0, [R1]
			NOP
			NOP
			NOP
			
			LDR		R1, =PortF_BASE
			LDR		R2, =GPIO_DIR
			LDR		R0, [R1,R2]
			ORR		R0, #0x0e	; set f1,f2,f2 out
			STR		R0, [R1,R2]
			;ENABLE DEN
			LDR		R2, =GPIO_DEN
			LDR		R0, [R1,R2]
			ORR		R0, #0x0e; enable f4,f0
			STR		R0,	[R1,R2]
	
			;alternative fucntion
			LDR		R2,=GPIO_AFSEL
			LDR		R0, [R1,R2]
			ORR		R0, #0xe ;alternative function for f1,f2,f3
			STR		R0, [R1,R2]
			;choose timer functions
			LDR		R2, =GPIO_PCTL
			LDR		R0, [R1,R2]
			
			LDR		R3, =0x000FFF0 ;alternative fuction timer index 7 
			BIC		R0, R3
			LDR		R3, =0x0007770
			ORR		R0, R3 
			STR		R0, [R1,R2]
			
			;DISABLE ANALOG
			LDR		R2, =GPIO_AMSEL
			LDR		R0, [R1,R2]
			BIC		R0, #0x0e ;f4, f0 disable anog
			STR		R0, [R1,R2]	
			
			POP		{R0-R3}
			BX 		LR
			ENDP
				
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;timer pwm init for t0,t1 @param r3: timer address
led_timer_pwm_init	PROC
			PUSH	{R0-R2}
			LDR 	R1,=RCGCTIMER
			LDR		R0, [R1]
			ORR		R0,	#0x03; clock timer 1 and 0
			STR		R0, [R1]
			NOP
			NOP
			NOP
		
			LDR		R1, =TIMER0
			
			;select16 bit timer
			LDR		R2, =TIMER_CFG
			MOV		R0, #0x04
			STR		R0, [R1,R2]
			
			;disable timers B
			LDR		R2, =TIMER_CTL
			LDR		R0, [R1,R2]
			BIC		R0, #0x100
			STR		R0, [R1,R2]
			
			;
			LDR 	R2, =TIMER_TBMR
			MOV 	R0, #0x0A ; set to periodic, count down pwm
			STR 	R0, [R1,R2]
			;
			LDR 	R2, =TIMER_TBILR ; initialize match clocks
			LDR 	R0, =0xffff
			STR		R0, [R1,R2]
			
			LDR		R2, =TIMER_TBMATCHR
			LDR		R0, =0x6000
			STR		R0, [R1,R2]
			;enable
			LDR		R2, =TIMER_CTL
			LDR		R0, [R1,R2]
			ORR		R0, #0x100
			STR		R0, [R1,R2] 
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;for timer 1
			LDR		R1, =TIMER1
			;select16 bit timer
			LDR		R2, =TIMER_CFG
			MOV		R0, #0x04
			STR		R0, [R1,R2]
			;;
			LDR		R2, =TIMER_CTL
			LDR		R0, [R1,R2]
			LDR		R3, =0x101
			BIC		R0, R3
			STR		R0, [R1,R2] 
			LDR 	R2, =TIMER_TAMR
			MOV 	R0, #0x0A ; set to periodic, count down pwm
			STR 	R0, [R1,R2]
			LDR 	R2, =TIMER_TBMR
			MOV 	R0, #0x0A ; set to periodic, count down pwm
			STR 	R0, [R1,R2]
			;
			LDR 	R2, =TIMER_TAILR ; initialize match clocks
			LDR 	R0, =0xffff
			STR		R0, [R1,R2]
			LDR 	R2, =TIMER_TBILR ; initialize match clocks
			LDR 	R0, =0xffff
			STR		R0, [R1,R2]
			
			LDR		R2, =TIMER_TAMATCHR
			LDR		R0, =LED_DEFAULT_BRGHTNESS
			STR		R0, [R1,R2]
			LDR		R2, =TIMER_TBMATCHR
			LDR		R0, =LED_DEFAULT_BRGHTNESS
			STR		R0, [R1,R2]
			
		
			LDR		R2, =TIMER_CTL
			LDR		R0, [R1,R2]
			LDR		R3, =0x101
			ORR		R0, R3
			STR		R0, [R1,R2] 
			
			POP		{R0-R2}
			BX		LR
			ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;pwm_write	@param r0: led select (r,g,b) = (0,1,2), r5: pwm val 
led_pwm_write	PROC
		PUSH	{R0-R2}
		LDR		R1, =0xffff
		AND		R5, R1
		sub		r5, r1, r5
		CMP		R0, #0
		BEQ		RED
		CMP		R0, #1
		BEQ		GREEN
		CMP		R0, #2
		BEQ		BLUE
		B		DONE
		
RED		LDR		R1, =TIMER0
			;disable timers B
		LDR		R2, =TIMER_CTL
		LDR		R0, [R1,R2]
		BIC		R0, #0x100
		STR		R0, [R1,R2]
		
		LDR		R2, =TIMER_TBMATCHR
		MOV		R0, R5
		STR		R0, [R1,R2]
		
		LDR		R2, =TIMER_CTL
		LDR		R0, [R1,R2]
		ORR		R0, #0x100
		STR		R0, [R1,R2]
		
		PUSH	{LR}
		LDR		R1, =TIMER1
		MOV		R0, #0
		BL		turnOffTimer
		MOV		R0, #1
		BL		turnOffTimer
		POP		{LR}
		B		DONE

GREEN	LDR		R1, =TIMER1
			;disable timers B
		LDR		R2, =TIMER_CTL
		LDR		R0, [R1,R2]
		BIC		R0, #0x100
		STR		R0, [R1,R2]
		
		LDR		R2, =TIMER_TBMATCHR
		MOV		R0, R5
		STR		R0, [R1,R2]
		
		LDR		R2, =TIMER_CTL
		LDR		R0, [R1,R2]
		ORR		R0, #0x100
		STR		R0, [R1,R2]
		
		PUSH	{LR}
		LDR		R1, =TIMER0
		MOV		R0, #1
		BL		turnOffTimer
		LDR		R1, =TIMER1
		MOV		R0, #0
		BL		turnOffTimer
		POP		{LR}
		B		DONE

BLUE	LDR		R1, =TIMER1
			;disable timers B
		LDR		R2, =TIMER_CTL
		LDR		R0, [R1,R2]
		BIC		R0, #0x001
		STR		R0, [R1,R2]
		
		LDR		R2, =TIMER_TAMATCHR
		MOV		R0, R5
		STR		R0, [R1,R2]
		
		LDR		R2, =TIMER_CTL
		LDR		R0, [R1,R2]
		ORR		R0, #0x001
		STR		R0, [R1,R2]
		
		PUSH	{LR}
		LDR		R1, =TIMER0
		MOV		R0, #1
		BL		turnOffTimer
		LDR		R1, =TIMER1
		BL		turnOffTimer
		
		POP		{LR}
		B		DONE
DONE	POP		{R0-R2}	
		BX		LR
		ENDP
;****************************************;
;R1= timer addres , r0: (A,B)= (0,1)
turnOffTimer PROC
	PUSH	{R0-R4}
	CMP		R0,#2
	BHS		disableDone
	
disableA
	LDR		R2, =TIMER_CTL
	LDR		R3, [R1,R2]
	LDR		R4, =0x101
	BIC		R3, R4
	STR		R3, [R1,R2]
	CMP		R0, #0
	LDREQ	R2, =TIMER_TAMATCHR
	LDRNE	R2, =TIMER_TBMATCHR
	LDR		R3, =0xfffe
	STR		R3, [R1,R2]
	LDR		R2, =TIMER_CTL
	LDR		R3, [R1,R2]
	LDR		R4, =0X101
	ORR		R3, R4
	STR		R3, [R1,R2]
	B		disableDone
disableDone	
	POP		{R0-R4}
	BX		LR
	ENDP
	END