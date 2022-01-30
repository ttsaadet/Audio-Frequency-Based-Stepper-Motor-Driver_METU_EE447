			AREA	routines, CODE, READONLY
			THUMB
			GET		address.s
			
			EXPORT	stepper_out_init
			EXPORT	stepper_sw_init
			EXPORT	stepper_timer2_init
				
			EXPORT	stepper_timer2_setSpeed
			
			EXPORT	stepper_timer2_isr
			EXPORT	stepper_sw_gpio_isr
				
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;stepper direction button initilzation @param none, @return none
stepper_sw_init	PROC
			PUSH	{R0-R3}
			LDR		R1, =RCGCGPIO
			LDR		R0, [R1]
			ORR		R0, #0x20
			STR		R0, [R1]
			NOP
			NOP
			NOP
		
			;UNLOCK
			LDR		R1, =PortF_BASE
			LDR		R2, =GPIO_LOCK
			LDR 	R0, =UNLOCKVAL
			STR		R0, [R1,R2]
			;COMMIT
			LDR 	R2, =GPIO_COMMIT
			MOV		R0, #0X3F
			STR		R0, [R1,R2]
			;SET DIR
			LDR		R2, =GPIO_DIR
			LDR		R0, [R1,R2]
			BIC		R0, #0x11	; set f4,F0 INPUT
			STR		R0, [R1,R2]
			;ENABLE DEN
			LDR		R2, =GPIO_DEN
			LDR		R0, [R1,R2]
			ORR		R0, #0x11; enable f4,f0
			STR		R0,	[R1,R2]
			;PULL UP
			LDR		R2, =GPIO_PUR
			LDR		R0, [R1,R2]
			ORR		R0, #0x11 ;f4, f0 pull up
			STR		R0, [R1,R2]
	
			;AFSEL RESET
			LDR		R2, =GPIO_AFSEL
			LDR		R0, [R1,R2]
			BIC		R0, #0x11 ;f4,f0 afsel reset
			STR		R0, [R1,R2]
			;DISABLE ANALOG
			LDR		R2, =GPIO_AMSEL
			LDR		R0, [R1,R2]
			BIC		R0, #0x11 ;f4, f0 disable anog
			STR		R0, [R1,R2]	
			;ENABLE INTERRUPTS;;;;;;;;;;;
			;make it sensitive to one edge
			LDR		R2, =GPIO_IBE
			LDR		R0, [R1,R2]
			BIC		R0,	#0x11
			STR		R0, [R1,R2]
			;fallng edge
			LDR		R2, =GPIO_IEV
			LDR		R0,	[R1,R2]
			BIC		R0,	#0x11; falling edge trigerring for f1 f2
			STR		R0,	[R1,R2]
			;not mask
			LDR		R2, =GPIO_IM
			LDR		R0, [R1,R2]
			ORR		R0, #0x11; enable for f4,f0
			STR		R0,	[R1,R2]
			
			;enable NVIC
			;set prioirtyu
			LDR		R1, =NVIC_BASE
			LDR		R2, =NVIC_PRI7
			LDR		R0, [R1,R2]
			ORR		R0, #0x00800000 ; set priotirty 4 [100]0 = 8
			STR		R0, [R1,R2]
			;enable
			LDR		R2, =NVIC_EN0
			LDR		R0, [R1,R2]
			ORR		R0,	#0x40000000 ; FORT F bit30 in nvic register
			STR		R0, [R1,R2]
			
			POP		{R0-R3}
			BX		LR
			ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;stepper outputs initilzation c0-c3 pins @param: none @return: none
stepper_out_init	PROC
			PUSH	{R0-R2}
			
			LDR		R1, =RCGCGPIO
			LDR		R0, [R1]
			ORR		R0, #0x02 ; USE PORT b
			STR		R0, [R1]
			NOP
			NOP
			NOP
			
			LDR		R1, =PortB_BASE
			LDR		R2, =GPIO_DIR
			LDR		R0, [R1,R2]
			ORR		R0, #0x0F	; set b0, b1,b2 ,b3 out
			STR		R0, [R1,R2]
			;ENABLE DEN
			LDR		R2, =GPIO_DEN
			LDR		R0, [R1,R2]
			ORR		R0, #0x0f; enable 
			STR		R0,	[R1,R2]
	
			;alternative fucntion
			LDR		R2,=GPIO_AFSEL
			LDR		R0, [R1,R2]
			BIC		R0, #0xf 
			STR		R0, [R1,R2]
			
			;DISABLE ANALOG
			LDR		R2, =GPIO_AMSEL
			LDR		R0, [R1,R2]
			BIC		R0, #0x0F ;
			STR		R0, [R1,R2]	
			

			
			LDR		R1,=STEPPER_DIR_ADDR
			MOV		R0, #0x0
			STRB	R0, [R1]
			

			POP		{R0-R2}
			BX		LR
			ENDP
				

					
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;initilzae timer2 periodic timeout interrupt for stepper motor
;uses timer 2
stepper_timer2_init	PROC
			PUSH	{R0-R3}
			LDR 	R1,=RCGCTIMER
			LDR		R0, [R1]
			ORR		R0,	#0x04; clock timer 2
			STR		R0, [R1]
			NOP
			NOP
			NOP
		
			LDR		R1, =TIMER2
			;disable timers
			LDR		R2, =TIMER_CTL
			LDR		R0, [R1,R2]
			BIC		R0, #0x01
			STR		R0, [R1,R2]
			
			;select16 bit timer
			LDR		R2, =TIMER_CFG
			MOV		R0, #0x04 ;16 bit mode
			STR		R0, [R1,R2]
			;
			LDR 	R2, =TIMER_TAMR
			MOV 	R0, #0x02 ; set to periodic, count down 
			STR 	R0, [R1,R2]
			;
			LDR		R2, =TIMER_TAPR
			MOV		R0, #79 	;prescaler 79, get 1us count interval 
			STR		R0, [R1,R2]
			
			;
			LDR 	R2, =TIMER_TAILR ; load value, 
			LDR 	R0, =10000
			STR		R0, [R1,R2]
			;
			LDR		R2, =TIMER_IMR ; enable timeout interrupt
			MOV 	R0, #0x01
			STR	 	R0, [R1,R2]
			

			;;;;;CONFIG NVIC TIMER2A INTTERYPT 23
			LDR		R1, =NVIC_BASE
			LDR		R2, =NVIC_PRI5
			LDR		R0, [R1,R2]
			LDR		R3, =0x70000000 ;priorty 7
			ORR		R0,R3
			STR		R0, [R1,R2]
			
			LDR		R2, =NVIC_EN0
			LDR		R0, [R1,R2]
			LDR		R3, =0x00800000 ;23th bit 1
			ORR		R0, R3
			STR		R0, [R1,R2]
			
						;enable
			ldr		R1, =TIMER2
			LDR		R2, =TIMER_CTL
			LDR		R0, [R1,R2]
			ORR		R0, #0x01
			STR		R0, [R1,R2] 
			
			POP		{R0-R3}
			BX		LR
			ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;timer2_setSpeed adjust interrupt interval @param r4 in uS @return :none
stepper_timer2_setSpeed	PROC
				PUSH	{R0-R2}

				LDR		R1, =TIMER2
				;disable timers
				LDR		R2, =TIMER_CTL
				LDR		R0, [R1,R2]
				BIC		R0, #0x01
				STR		R0, [R1,R2]
									
				LDR		R2, =TIMER_TAILR
				STR		R4, [R2,R1]
				
				;ENABLE timers
				LDR		R2, =TIMER_CTL
				LDR		R0, [R1,R2]
				ORR		R0, #0x01
				STR		R0, [R1,R2]
				
				POP		{R0-R2}
				BX 		LR
				ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;interrupt handler for direction set
;;switch interrupt handler for determining rotation direction of stepper
stepper_sw_gpio_isr	PROC
				PUSH {R0-R2}
				LDR	R1,=PortF_BASE
				LDR	R2, =GPIO_RIS
				LDR	R0, [R1,R2]
				AND	R0, #0x11
				CMP	R0, #0x01
				BEQ	_gsh_SW1
				CMP	R0,	#0x10
				BEQ	_gsh_SW2
				BNE	_gsh_done
_gsh_SW1		MOV	R0, #0x0 ;rotate cw
				LDR	R1, =STEPPER_DIR_ADDR
				STRB R0, [R1]
				B	_gsh_done
_gsh_SW2		MOV	R0,	#0x1
				LDR	R1, =STEPPER_DIR_ADDR
				STRB R0, [R1]
				B	_gsh_done
_gsh_done		LDR	R1,=PortF_BASE
				LDR	R2,=GPIO_ICR
				MOV	R0, #0xff
				STR	R0, [R1,R2] ;clear interrupt flags
				POP	{R0-R2}
				BX	LR
				ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;timer2_isr_handler for step driving called by nvic
stepper_timer2_isr	PROC
		
		LDR		R1, =TIMER2
		LDR		R2, =TIMER_ICR
		LDR		R0, [R1,R2]
		ORR		R0,	#0x1
		STR		R0, [R1,R2]
		
		LDR		R1, =STEPPER_DIR_ADDR
		LDRB	R3, [R1]
		
		LDR		R1, =PortB_BASE
		LDR		R2, =0x3c ; first four pin
		LDR		R0, [R1,R2]
		
		CMP		R3, #0
		BEQ		CW
		CMP		R3, #1; IF CCW
		BEQ 	CCW
		
CW		CMP		R0, #0x00
		MOVEQ	R0, #0x10
		CMP		R0, #0x01
		MOVEQ	R0, #0X10
		LSR		R0, #1
		STR		R0, [R1,R2]
		B		done
CCW		CMP		R0, #0x00
		MOVEQ	R0, #0x01
		CMP		R0, #0X10
		MOVEQ	R0, #0X01
		LSL		R0, #1
		STR		R0, [R1,R2]
		B		done
done	BX		LR
	
		ENDP
		END