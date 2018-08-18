; haribote-ipl
; TAB=4

		ORG		0x7c00

		JMP	short	entry
		nop
		DB		'MSDOS5.0'	
		DW		512	
		DB 		8
		DW		36
		DB		2
		DW		0
		DW		0
		db 		0xf8
		dw		0
		dw		63
		dw		255
		dd		1	
		dd		15727634
		dd 		15330	
		dw		0
		dw		0
		dd		2
		dw		1
		dw		6
		times	12	db 0
		db		80h
		db		0
		db		29h
		dd		18467
		DB		"NO NAME    "	
		DB		"FAT32   "
entry:
		MOV		AX,0			
		MOV		SS,AX
		MOV		ES, AX
		MOV		SP,0x7c00
		MOV		DS,AX


		MOV		SI,msg
		call 		putloop
		jmp		fin
putloop:
		MOV		AL,[SI]
		ADD		SI,1			
		CMP		AL,0
		JE		over	
		MOV		AH,0x0e			
		MOV		BX,15			
		INT		0x10			
		JMP		putloop
over:
		ret
fin:
		HLT					
		JMP		fin	
msg:
		DB		0x0a, 0x0a	
		DB		"hello os"
		DB		0x0a			
		DB		0

;		RESB		0x7dfe-$		
		times 		510 - ($ - $$) db 0
		DB		0x55, 0xaa
