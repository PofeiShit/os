; haribote-ipl
; TAB=4

		ORG		0x7c00		

		JMP	short	entry
		nop
		DB		'MSDOS5.0'	;"HARIBOTE"	
		DW		512				
		DB 		8	
		DW		2114	
		DB		2
		DW		0
		DW		0
		db 		0xf8
		dw		0
		dw		63
		dw		255
		dd		63	
		dd		15727572	
		dd 		15327	
		dw		0
		dw		0
		dd		2
		dw		1
		dw		6
		times	12	db 0
		db		80h
		db		0
		db		29h
		dd		101042579	
		DB		"NO NAME    "	
		DB		"FAT32   "
entry:
		MOV		AX,0			
		MOV		SS,AX
		MOV		ES, AX
		MOV		SP,0x7c00
		MOV		DS,AX

		MOV		AX,0x0820
		MOV		ES,AX
		MOV		CH,2			
		MOV		DH,11
		MOV		CL,9			
		MOV 		[0x7dfe], DL
readloop:
		MOV		SI,0			
retry:
		MOV		AH,0x02			
		MOV		AL,1			
		MOV		BX,0
		MOV		DL,[0x7dfe]			
		INT		0x13			
		JNC		next			
		ADD		SI,1			
		CMP		SI,5			
		JAE		error			
		MOV		AH,0x00
		MOV		DL,0x00			
		INT		0x13			
		JMP		retry
next:
		MOV		AX,ES			
		ADD		AX,0x0020
		MOV		ES,AX			
		ADD		CL,1			
		CMP		CL,63	
		JBE		readloop		

		MOV 		CL, 1
		ADD		DH, 1
		CMP		DH, 19
		JB		readloop

;		push		ds
;		mov		ax, 0x820
;		mov		ds, ax
;		mov		bx, 0x0
;		mov		dl, [bx]
;		mov		dh, 0xff
;		call		dispreg16
		JMP		0xc200	


error:
		MOV		SI,msg
putloop:
		MOV		AL,[SI]
		ADD		SI,1		
		CMP		AL,0
		JE		FINISH	
		MOV		AH,0x0e			
		MOV		BX,15		
		INT		0x10		
		JMP		putloop
FINISH:
		ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
dispreg16:
		mov		cl, 16
bit:
		push		cx
		push		dx
		
		sub		cl, 1
		shr		dx, cl
		call 		dispbit
		
		cmp 		cl, 8
		jne		skipblank
		mov		al, 0x20
		mov		ah, 0x0e
		mov		bx, 15
		int 		0x10
skipblank:
		pop		dx
		pop		cx
		sub		cl, 1
		cmp		cl, 0
		jne 		bit
		ret
dispbit:
		xor		ax, ax
		mov		ax, dx
		and		ax, 1
		add		al, 0x30
		mov		ah, 0x0e
		mov		bx, 15
		int		0x10
		ret
fin:
		HLT						
		JMP		fin			
msg:
		DB		0x0a, 0x0a		
		DB		"load error"
		DB		0x0a		
		DB		0

		;RESB	0x7dfe-$		
		times 510 - ($ - $$) db 0
		DB		0x55, 0xaa
