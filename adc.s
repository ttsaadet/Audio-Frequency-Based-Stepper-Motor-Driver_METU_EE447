
	

			AREA 	main,CODE,READONLY
			THUMB
			GET		address.s
			EXPORT 	adc_init
			EXPORT	adc_read
			EXPORT  adc_isr_handler
			


adc_init	PROC
			push	{r0-r2}
			;clock adc peripheral
			ldr		r1, =RCGCADC
			
			ldr		r0, [r1]
			orr		r0, #0x01 ;use adc0
			str		r0, [r1]
			nop
			nop
			nop
			
			;clock gpio
			LDR		r1, =RCGCGPIO
			LDR		r0, [r1]
			ORR		r0, #0x10 ;use port e
			str		r0, [r1]
			nop
			nop
			nop
			
			ldr		r1, =PortE_BASE
			;INPUT OUTPUT DECLERATION
			ldr		r2, =GPIO_DIR
			ldr		r0, [r1, r2]
			bic		r0, #0x0f  
			str		r0, [r1, r2]
			
			;Alternative function 
			ldr		r2, =GPIO_AFSEL
			ldr		r0, [r1,r2]
			orr		r0, #0x0f ;
			str		r0, [r1, r2]
			
					
			;disable digital 
			LDR		r2, =GPIO_DEN
			LDR		r0, [r1, r2]
			BIC		r0, #0x0f
			STR		r0, [r1, r2]
		
			;enable analog mode
			ldr		r2, =GPIO_AMSEL
			ldr		r0, [r1,r2]
			orr		r0, #0x0f
			str		r0, [r1,r2]

			ldr		r1, =ADC0_BASE
			;disable sequence2 sampler for conf
			ldr		r2, =ADCACTSS
			ldr		r0, [r1]
			bic		r0, #0x04
			str		r0, [r1]
			

			
			;conf software triggering sample start
			ldr		r2, =ADCEMUX
			str		r0, [r1,r2]
			bic		r0, #0x0f00
			str		r0, [r1,r2]
			
			;ain0, ain1, ain2, ain3 
			ldr		r2, =ADCSSMUX2
			mov32	r0, #0x3210
			str		r0, [r1,r2]
			
			;enable interrupt and set end0 bit
			ldr		r2, =ADCSSCTL2
			;ldr		r0, [r1,r2]
			mov		r0, #0x0006
			str		r0, [r1,r2]
			
			;500ksps
			ldr		r2, =ADCPC
			mov		r0, #0x05
			str		r0, [r1,r2]
			
			ldr		r2, =ADCIM
			ldr		r0, [r1,r2]
			orr		r0, #0x04
			str		r0, [r1,r2]
			
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			;set irq priorty
			ldr		r1, =NVIC_BASE
			ldr		r2, =NVIC_PRI4
			ldr		r0, [r1,r2]
			orr		r0, #0x40	;priority 2  [100]0 0000
			str		r0, [r1,r2]
			;enable nvic adc0
			ldr		r2, =NVIC_EN0
			ldr		r0, [r1,r2]
			orr		r0, #0x00010000 ; set16th bit for interrupt 16 for adc0
			str		r0, [r1,r2]
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			
			
			;enable adC
			ldr		r1, =ADC0_BASE
			ldr		r2, =ADCACTSS
			mov		r0, #0x04 ;enable seq2
			str		r0, [r1,r2]
			
			ldr		r1, =MIC_SAMPLE_OFSET_ADDR
			mov		r0, #0x0
			str		r0, [r1]
			pop		{r0-r2}
			bx 		lr
			ENDP
;read				
adc_read	PROC

			ENDP

adc_isr_handler	PROC
				ldr		r1, =ADC0_BASE
				;clear interrypt flag
				ldr		r2, =ADCISC
				ldr		r0, [r1,r2]
				orr		r0, #0x04
				str		r0, [r1,r2]
				
				ldr		r1, =ADC0_BASE
				mov		r12, #0 		;read cycle for multiple adc in
_readFifo		ldr		r2, = ADCSSFIFO2
				ldr		r0, [r1,r2]		;r0 has 12 bit value 
;				add 	r12, #1
;				cmp		r12, #1
;				beq		_strMic
;				cmp		r12, #2
;				beq		_strPot1
;				cmp		r12, #3
;				beq		_strPot2
;				cmp		r12, #4
;				bne		_readFifo
;				mov		r12, #0 
;				b		_strPot3
;				b		done
_strMic			ldr		r2, =MIC_ADC_OFFSET
				sub		r0, r2
				lsl		r0, #4
				ldr		r2, =0xffff0000
				bic		r0, r2
				ldr		r2, =MIC_SAMPLE_DATA_ADDR;
				str		r0, [r2,r11] ;store value
				
				add		r11, #4
				cmp		r11, #0x400
				moveq	r11, #0
				moveq	r10, #1
				b		done
_strPot1		ldr		r2, =LOW_FREQ_TH_ADDR_POT1
				str		r0, [r2]
				b		_readFifo
_strPot2		ldr		r2, =HIGH_FREQ_TH_ADDR_POT2
				str		r0, [r2]
				b		_readFifo
_strPot3		ldr		r2, =AMP_TH_ADDR_POT3
				str		r0, [r2]
				b		done
done			bx	lr		
			ENDP

			END