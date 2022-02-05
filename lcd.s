            AREA        sdata, DATA, READONLY
            THUMB
CHAR_A  DCB	0x7e, 0x11, 0x11, 0x11, 0x7e, 0x0f
		DCB	0x00
		DCB	0x00
		DCB	0x00
CHAR_E	DCB 0x7f, 0x49, 0x49, 0x49, 0x41, 0x0f ;// 45 E 
CHAR_F	DCB	0x7f, 0x09, 0x09, 0x09, 0x01, 0x0f ;// 46 F 
CHAR_G 	DCB 0x3e, 0x41, 0x49, 0x49, 0x7a, 0x0f ;// 47 G
CHAR_H 	DCB 0x7f, 0x08, 0x08, 0x08, 0x7f, 0x0f ;// 48 H
		DCB 0x00, 0x41, 0x7f, 0x41, 0x00, 0x0f ;// 49 I 
		DCB 0x20, 0x40, 0x41, 0x3f, 0x01, 0x0f ;// 4a J 
		DCB 0x7f, 0x08, 0x14, 0x22, 0x41, 0x0f ;// 4b K 
CHAR_L 	DCB 0x7f, 0x40, 0x40, 0x40, 0x40, 0x0f ;// 4c L 
CHAR_M 	DCB 0x7f, 0x02, 0x0c, 0x02, 0x7f, 0x0f ;// 4d M 
CHAR_O 	DCB 0x3e, 0x41, 0x41, 0x41, 0x3e, 0x0f ;// 4f O 
CHAR_Q 	DCB 0x3e, 0x41, 0x51, 0x21, 0x5e, 0x0f ;// 51 Q
CHAR_R	DCB 0x7f, 0x09, 0x19, 0x29, 0x46, 0x0f ;// 52 R
CHAR_T	DCB	0x01, 0x01, 0x7f, 0x01, 0x01, 0x0f ;// 54 T 
CHAR_W 	DCB 0x3f, 0x40, 0x38, 0x40, 0x3f, 0x0f;// 57 W 
NULL			DCB 0x00, 0x00, 0x00, 0x00, 0x00, 0x0f 
STR_MAG 		DCB 0x7f, 0x02, 0x0c, 0x02, 0x7f, 0x7e, 0x11, 0x11, 0x11, 0x7e, 0x3e, 0x41, 0x49, 0x49, 0x7a, 0x0f
STR_MAG_TH		DCB 0x7f, 0x02, 0x0c, 0x02, 0x7f, 0x7e, 0x11, 0x11, 0x11, 0x7e, 0x3e, 0x41, 0x49, 0x49, 0x7a
				DCB	0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x7f, 0x01, 0x01, 0x7f, 0x08, 0x08, 0x08, 0x7f, 0x0f
STR_FREQ		DCB 0x7f, 0x09, 0x09, 0x09, 0x01, 0x7f, 0x09, 0x19, 0x29, 0x46, 0x7f, 0x49, 0x49, 0x49, 0x41, 0x0f
STR_FREQ_LOW 	DCB 0x7f, 0x09, 0x09, 0x09, 0x01, 0x7f, 0x09, 0x19, 0x29, 0x46, 0x7f, 0x49, 0x49, 0x49, 0x41
				DCB	0x00, 0x00, 0x00, 0x00, 0x00, 0x7f, 0x40, 0x40, 0x40, 0x40, 0x3e, 0x41, 0x41, 0x41, 0x3e
				DCB	0x3f, 0x40, 0x38, 0x40, 0x3f 
				DCB	0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x7f, 0x01, 0x01, 0x7f, 0x08, 0x08, 0x08, 0x7f ,0x0f
STR_FREQ_HIGH	DCB	0x7f, 0x09, 0x09, 0x09, 0x01, 0x7f, 0x09, 0x19, 0x29, 0x46, 0x7f, 0x49, 0x49, 0x49, 0x41
				DCB	0x00, 0x00, 0x00, 0x00, 0x00, 0x7f, 0x08, 0x08, 0x08, 0x7f, 0x00, 0x41, 0x7f, 0x41, 0x00
				DCB	0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x7f, 0x01, 0x01, 0x7f, 0x08, 0x08, 0x08, 0x7f ,0x0f

NUM_0	DCB 0x3e, 0x51, 0x49, 0x45, 0x3e, 0x0f ;// 30 0 
		DCB 0x00, 0x42, 0x7f, 0x40, 0x00, 0x0f ;// 31 1 
		DCB 0x42, 0x61, 0x51, 0x49, 0x46, 0x0f ;// 32 2 
		DCB 0x21, 0x41, 0x45, 0x4b, 0x31, 0x0f ;// 33 3 
		DCB 0x18, 0x14, 0x12, 0x7f, 0x10, 0x0f ;// 34 4 
		DCB 0x27, 0x45, 0x45, 0x45, 0x39, 0x0f ;// 35 5 
		DCB 0x3c, 0x4a, 0x49, 0x49, 0x30, 0x0f ;// 36 6 
		DCB 0x01, 0x71, 0x09, 0x05, 0x03, 0x0f ;// 37 7 
		DCB 0x36, 0x49, 0x49, 0x49, 0x36, 0x0f ;// 38 8 
		DCB 0x06, 0x49, 0x49, 0x29, 0x1e, 0x0f;	// 39 9 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;d0 CLK 
;d1 FSS , chip select
;d2 RX
;d3 TX

;d6 reset
;d7 d/c
LCD_CS_ADDR_A3 			EQU	0x10
LCD_RESET_ADDR_A7 	EQU 0x200
LCD_DC_ADDR_A6		EQU	0X100

		AREA 	routines, CODE, READONLY
		THUMB
		GET		address.s
		EXPORT	lcd_init
		EXPORT	ssi_send
		EXPORT 	lcd_update_isr
		EXTERN	delay
		

lcd_init	PROC
			PUSH	{LR}
			BL		load_numbers
			BL		gpio_init
			BL		ssi_init
			BL		lcd_setup
			BL		lcd_timer_init
			POP		{LR}
			BX		LR
			ENDP
				
;**********************
gpio_init	PROC
			PUSH	{R0-R3}
			LDR		R1, =RCGCGPIO
			LDR		R0, [R1]
			ORR		R0, #0x01 ; a PORT
			STR		R0, [R1]
			NOP
			NOP
			NOP
		
			LDR		R1, =PortA_BASE
			;SET DIR
			LDR		R2, =GPIO_DIR
			LDR		R0, [R1,R2]
			ORR		R0, #0xff	;
			STR		R0, [R1,R2]
			;ENABLE DEN
			LDR		R2, =GPIO_DEN
			LDR		R0, [R1,R2]
			ORR		R0, #0xff; enable 
			STR		R0,	[R1,R2]
			
			;AFSEL SET
			LDR		R2, =GPIO_AFSEL
			MOV		R0, #0X3C  
			STR		R0, [R1,R2]
			
			;set afsel as spi
			LDR		R2, =GPIO_PCTL
			LDR		R0, =0x00222200
			STR		R0, [R1,R2]
			;DISABLE ANALOG
			LDR		R2, =GPIO_AMSEL
			LDR		R0, [R1,R2]
			BIC		R0, #0xff 
			STR		R0, [R1,R2]		
			
			POP		{R0-R3}
			BX		LR
			ENDP
;***********************************************
;lcd timer init, use timer3 RTC. Timer is used for update screen at every one seond
lcd_timer_init	PROC
		PUSH	{R0-R2}
		LDR 	R1,=RCGCTIMER
		LDR		R0, [R1]
		ORR		R0,	#0x08; clock timer3
		STR		R0, [R1]
		NOP
		NOP
		NOP
	
		LDR		R1, =TIMER3
		
		;disable timer
		LDR		R2, =TIMER_CTL
		LDR		R0, [R1,R2]
		BIC		R0, #0x01
		STR		R0, [R1,R2]
		;select16 bit timer
		LDR		R2, =TIMER_CFG
		MOV		R0, #0x04 ;16 bit mode
		STR		R0, [R1,R2]

		LDR 	R2, =TIMER_TAMR
		mov 	R0, #0x02 ; set to periodic, count down 
		STR 	R0, [R1,R2]
		;
					;
		LDR 	R2, =TIMER_TAILR ; load value, 
		LDR 	R0, =62500	 ;62500 * 256 = 16M, get every one second
		STR		R0, [R1,R2];
		
		LDR		R2, =TIMER_TAPR
		MOV		R0, #0xff 	 ;prescaler 256, get 15us count interval 
		STR		R0, [R1,R2]
		
		LDR		R2, =TIMER_TAMATCHR
		MOV		R0, #0
		STR		R0, [R1,R2]

		;
		LDR		R2, =TIMER_IMR ; enable timeout interrupt
		MOV 	R0, #0x01
		STR	 	R0, [R1,R2]
			
		;;;;;CONFIG NVIC TIMER3A INTTERYPT 23
		LDR		R1, =NVIC_BASE
		LDR		R2, =NVIC_PRI8
		LDR		R0, [R1,R2]
		LDR		R3, =0x30000000 ;priorty 3
		ORR		R0,R3
		STR		R0, [R1,R2]
		
		LDR		R2, =NVIC_EN1
		LDR		R0, [R1,R2]
		LDR		R3, =0x00000008 ;3th bit 1
		ORR		R0, R3
		STR		R0, [R1,R2]
		
		LDR		R1,=TIMER3
		;enable
		LDR		R2, =TIMER_CTL
		LDR		R0, [R1,R2]
		ORR		R0, #0x001
		STR		R0, [R1,R2]
		
		POP		{R0-R2}
		BX		LR
		ENDP

;******************************
;The method to write program for controlling operation of 
;LCD is to set operation of LCD first or called “Initial LCD”. 
lcd_setup PROC
		PUSH	{LR, R0-R2}
		LDR		R1, =PortA_BASE
		LDR		R2, =LCD_RESET_ADDR_A7
		;TOGGLE RESET PIN
		MOV		R0, #0Xff
		STR		R0, [R1,R2]
		BL		delay
		MOV		R0, #0x00

		STR		R0, [R1,R2]
		BL		delay
		MOV		R0, #0xff
		STR		R0, [R1,R2]
		;chip select low
		LDR		R1, =PortA_BASE
		LDR		R2, =LCD_CS_ADDR_A3
		MOV		R0,	0x00
		STR		R0, [R1,R2]
		
		;function set
		MOV		R4, #0 	   ;use data mode
		MOV		R3, #0x20 ; bsic set, pd = 0, v = 0, h = 0
		BL		ssi_send
		BL		delay
		MOV		R3, #0x0c ;display control set D = 1, E = 0 normal mode
		BL		ssi_send
		
		;set x addres to 0 
		MOV		R3, #0x80
		BL		ssi_send
		;set y address to 0
		MOV		R3, #0x40
		BL		ssi_send
		;enable data send
		LDR	R1, =PortA_BASE
		LDR	R2, =LCD_DC_ADDR_A6
		MOV	R0, #0xff
		STR	R0, [R1,R2]
		
		BL		lcd_create_table
		
		POP		{LR, R0-R2}
		BX		LR
		ENDP
;****************************************************
;@param none
lcd_create_table	PROC
		PUSH	{LR,R3,R4}
		BL		lcd_print_reset	
		MOV		R5, 0
		MOV		R4, #1 ; use ssi_send in address mode
		LDR		R3, =STR_MAG
		BL		ssi_send
		
		ADD		R5, #1
		MOV		R6,	#0
		BL		lcd_align_cursor
		LDR		R3, =STR_MAG_TH
		BL		ssi_send
		
		LDR		R3, =STR_FREQ
		ADD		R5, #1
		MOV		R6, #0
		BL		lcd_align_cursor
		BL		ssi_send
		
		ADD		R5, #1
		LDR		R3, =STR_FREQ_LOW
		BL		lcd_align_cursor
		BL		ssi_send
		
		ADD		R5, #1
		LDR		R3, =STR_FREQ_HIGH
		BL		lcd_align_cursor
		BL		ssi_send
		
		
		POP		{LR,R3,R4}
		BX		LR
		ENDP
;*************************************************
;suboutine that align cursor @param: r5= y (0-5), r6 = x(0,83) 
lcd_align_cursor	PROC
		PUSH {LR,R0-R4}
		LDR	R1, =SSI0
		LDR	R2, =SSISR
wait__	LDR	R0, [R1,R2]
		ANDS R0, #0x10; CHECK BUSY FLAG, IN TRANSMISSION CONTNUE NOT DISABLE THE DATA LINE
		BNE	wait__
		;disable data line
		LDR	R1, =PortA_BASE
		LDR	R2, =LCD_DC_ADDR_A6
		MOV	R0, #0x00
		STR	R0, [R1,R2]
	
	
		MOV	R4, #0 ;use data mode of ssi_send
		ORR	R3, R6, #0x80 ;set x address 
		BL	ssi_send
		ORR	R3, R5, #0x40 ;SET Y ADDRESS BIT NOKIA5110
		BL	ssi_send		
		BL	delay
		;enable data line
		LDR	R1, =PortA_BASE
		LDR	R2, =LCD_DC_ADDR_A6
		MOV	R0, #0xff
		STR	R0, [R1,R2]
		
		POP	{LR,R0-R4}
		BX	LR
		ENDP
			
;*****************************************
;print reset: clear screen by writing 83*6 zeros
lcd_print_reset	PROC
		PUSH 	{LR,R0-R6}
		LDR		R1, =SSI0
	
		mov32	r4, #532 ;84*6
		mov		r3, #0
wFifoReset LDR		R2, =SSISR
		LDR		R0, [R1,R2]
		ANDS	R0,	 0x1 ; check tfe flag 
		BEQ		wFifoReset
		LDR		R2, =SSIDR
		STRB	R3, [R1,R2]
		SUB		r4, #1
		CMP		r4, #0
		BEQ		resetDone
		B		wFifoReset
resetDone
		MOV		R5,#0
		MOV		R6,#0
		BL		lcd_align_cursor ;reset cursor 
		POP		{LR,R0-R6}
		BX 		LR
		ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;timer3_isr that updates screen in every seceond
lcd_update_isr	PROC
		PUSH	{LR,R0-R5}
		LDR		R1, =TIMER3
		LDR		R2, =TIMER_ICR
		LDR		R0, [R1,R2]
		ORR		R0,	#0X1
		STR		R0, [R1,R2] ; CLEAR INTERRUPT FLAG
		
		
		LDR		R0, =CURRENT_AMP_ADDR
		LDR		R1, [R0]
		MOV		R5, #0
		BL		print_digit ;convert hex number to BCD and print digit by digit, r1 hex, r5 row
		
		LDR		R0, =AMP_TH_ADDR_POT3
		LDR		R1, [R0]
		MOV		R5, #1
		BL		print_digit ;convert hex number to BCD and print digit by digit, r1 hex, r5 row
		
		LDR		R0, =CURRENT_FREQ_ADDR
		LDR		R1, [R0]
		MOV		R5, #2
		BL		print_digit ;convert hex number to BCD and print digit by digit, r1 hex, r5 row
		
		LDR		R0, =LOW_FREQ_TH_ADDR_POT1
		LDR		R1, [R0]
		MOV		R5, #3
		BL		print_digit ;convert hex number to BCD and print digit by digit, r1 hex, r5 row
		
		LDR		R0, =HIGH_FREQ_TH_ADDR_POT2
		LDR		R1, [R0]
		MOV		R5, #4
		BL		print_digit ;convert hex number to BCD and print digit by digit, r1 hex, r5 row
		
		
		POP		{LR,R0-R5}
		
		BX		LR
		ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
load_numbers	PROC
		PUSH	{LR,R0-R3}
		MOV		R3, #60
		LDR		R1, =NUM_0
		LDR		R2, =LCD_NUMBER_START_ADDR
load_	LDR		R0, [R1] ,#1
		STR		R0, [R2] ,#1
		SUBS	R3, #1
		BNE		load_
		
		POP		{LR,R0-R3}
		BX		LR
		ENDP

;********************************************
;SPI send routine @param: r3 = one byte data (r4 = 0) , or start address (r4 = 1), @param r4: mode type
ssi_send	PROC
		PUSH 	{LR,R0-R2}
		;chip select low
		LDR		R1, =SSI0
		CMP	R4, #1
		BEQ	address_mode
		BNE	byte_mode
byte_mode		
wFifoB	LDR		R2, =SSISR
		LDR		R0, [R1,R2]
		ANDS	R0,	 0x1 ; check tfe flag 
		BEQ		wFifoB
		LDR		R2, =SSIDR
		MOV		R0, R3
		STRB	R0, [R1,R2]
		B		done
address_mode
wFifoA	LDR		R2, =SSISR
		LDR		R0, [R1,R2]
		ANDS	R0,	 0x1 ; check tfe flag 
		BEQ		wFifoA
		LDRB	R0, [R3], #1
		CMP		R0, #0xf
		BEQ		done
		LDR		R2, =SSIDR
		STR		R0,	[R1,R2]
		B		address_mode
done
		POP		{LR,R0-R2}
		BX 		LR
		ENDP


;***************************
ssi_init	PROC
			PUSH {R0-R3}
			LDR R1, =RCGCSSI
			LDR	R0, [R1]
			ORR	R0, #0x01
			STR	R0, [R1]
			NOP
			NOP
			NOP
			
			LDR	R1, =SSI0
			;disable ssi
			LDR	R2,	=SSICR1
			MOV	R0,	#0x02
			STR	R0, [R1,R2]
			;clock configuration
			LDR	R2, =SSICPSR
			MOV	R0, #0x2
			STR	R0, [R1,R2] ;presecaler 4, run spi in 2mhz. 2 = 16 / (4 * (1+1))
			LDR	R2, =SSICR0
			LDR	R0, [R1,R2]
			BFC	R0, #8, #8
			ORR	R0, #0x100 ;1 clock rate (1+1) 
			STR	R0,	[R1,R2]
			;;; set data length 8bit and use freescale
			BIC	R0, #0x1F
			ORR	R0, #0X07
			STR	R0, [R1,R2]
			;enable ssi
			LDR	R2,	=SSICR1
			LDR	R0, [R1,R2]
			ORR	R0, #0X02
			STR	R0, [R1,R2]	
			
			POP	{R0-R3}
			BX	LR
			ENDP
;***********************************************				
;converts hex number to decimal in char and prints to lcd 
;@param: R1= hex number to be printed @param: r5 row number
print_digit	PROC
		PUSH	{LR,R0-R3,R5}
		MOV		R6,#64
		BL		lcd_align_cursor ;r5 row, r6 x pixel
		MOV		R6, #0
cnStart	MOV		R0, #10
		SDIV	R2, R1, R0
		MUL		R3, R2, R0
		SUB		R4, R1, R3 ;R4 HOLDS DIGIT
		MOV		R1, R2
		ADD		R6, #1
		CMP		R6, #4
		BEQ		cnDone
		B		print
print	PUSH	{R0-R4}
		MOV		R0, #6
		LDR		R3, =LCD_NUMBER_START_ADDR
		MUL		R4, R6
		ADD		R3, R4 ;R3 EFFECTIVE ADDRESS
		MOV		R4,#1 ;USE SSI_SEND UN ADDRESSING MODE
		BL		ssi_send
		POP		{R0-R4}
		B		cnStart
cnDone	
		POP		{LR,R0-R3,R5}
		BX 	LR
		ENDP		
			END