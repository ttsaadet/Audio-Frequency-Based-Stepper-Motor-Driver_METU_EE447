
		AREA 	routines, CODE, READONLY
		GET		address.s
		THUMB
		EXPORT	clock_configure

clock_configure	PROC
		PUSH	{R0-R2}
		LDR		R1, =SYSCTL_RCC2
		LDR		R0, [R1]
		ORR		R0, 0x80000000 ;use rcc2 not rcc,
		STR		R0, [R1]
		;
		
		ORR		R0, #0x00000800 ;bypass pll while configuring
		STR		R0, [R1]
		;

		LDR		R1, =SYSCTL_RCC
		LDR		R0, [R1]
		LDR		R2, =0x000007C0;clear xtal fields 10-6 bits
		BIC		R0, R2
		LDR		R2, =0x00000540; 16 mhz external ossc
		ORR		R0, R2
		STR		R2, [R1] 
		;select mosc
		LDR		R1, =SYSCTL_RCC2
		LDR		R0, [R1]
		BIC		R0, #0x70
		STR		R0, [R1]
		;
		BIC		R0,	#0x00002000 ;clear pwrdwn bit
		ORR		R0,	#0x40000000 ; use 400 mhz
		STR		R0, [R1]
		
		LDR		R2, =0x1FC00000
		BIC		R0, R2
		ORR		R0, #0x01000000; divisor 5 
		STR		R0, [R1]
		
		LDR		R1, =SYSCTL_RIS
poll	LDR		R0, [R1]
		ANDS	R0,	#0x40
		BEQ		poll
		
		;clear bypass bit to use pll
		LDR		R1, =SYSCTL_RCC2
		LDR		R0, [R1]
		BIC		R0, #0x00000800
		STR		R0, [R1]
		POP		{R0-R2}
		BX		LR
		ENDP