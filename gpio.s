


		AREA 		routines, CODE, READONLY
		THUMB
		GET			address.s




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;gpio_write @param r1 port addr, r2 pin number, r3 value
gpio_write	PROC
			PUSH	{R0-R3}
			ADD		R2,#1
			LSR		R2,#2
			STR		R3, [R1,R2]
			POP		{R0-R3}
			BX		LR
			ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;gpio_read @param r1 port addr, r2 pin number @return r3 val
gpio_read	PROC
			PUSH	{R0-R2}
			ADD		R2,#1
			LSR		R2,#2
			LDR		R3, [R1,R2]
			POP		{R0-R2}
			BX		LR
			ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

			END