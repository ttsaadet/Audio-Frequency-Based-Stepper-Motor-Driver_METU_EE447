			AREA main, READONLY, CODE
			THUMB
			EXPORT delay1s
				
delay1s		PROC	
			PUSH	{R0,R1}
			MOV		R1, #0
			MOV32 	R0, #5333
loop		ADD		R1, #1
			CMP		R1,	R0
			BNE		loop
			POP		{R0,R1}
			BX		LR
			ENDP
			END