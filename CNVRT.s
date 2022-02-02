;r4 input number, r5 address to write
OFFSET 	EQU		9
	
		AREA 	main ,READONLY,CODE
		THUMB
		EXPORT 	CNVRT

CNVRT	PROC
		PUSH	{R5}
		ADD		R5, #OFFSET
		PUSH	{R5}
		PUSH	{R0-R10}
loop	MOV		R2, #10
		SDIV	R0,R4, 	R2;  R0:RESULT R4DIVIDED BY 10, R4 = DECIMAL NUMBER R2 = 10
		MUL		R6,R0, R2
		SUB		R1,R4, 	R6 	; R1 LSB DIGIT
		ADD		R1,#48
		STRB	R1,[R5]
		SUB		R5,#1
		MOV		R4, R0
		CMP		R4, #0
		BNE		loop
		POP		{R5}
		mov		R1, #0X0D
		STRB	R1,[R5,#1]!
		MOV		R1, #0X04
		STRB	R1,[R5,#1]!
		POP		{R5}
skipIfZ	LDRB	R6, [R5]
		CMP		R6, #0X00
		ADDEQ	R5,#1
		BEQ		skipIfZ
		PUSH	{R0-R10}
		BX		LR
		ENDP
		END