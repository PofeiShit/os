; haribote-os
; TAB=4

		ORG		0x8400	; ���̃v���O�������ǂ��ɓǂݍ��܂��̂�
		MOV		SI, msg
		call 		putloop
		MOV		AL,0x13			; VGA�O���t�B�b�N�X�A320x200x8bit�J���[
		MOV		AH,0x00
		INT		0x10
fin:
		HLT
		JMP		fin
msg:
		DB 		0x0a
		DB 		"fuck test"
		DB 		0
putloop:
		MOV		AL,[SI]
		ADD		SI,1			; SI��1�𑫂�
		CMP		AL,0
		JE		FINISH	
		MOV		AH,0x0e			; �ꕶ���\���t�@���N�V����
		MOV		BX,15			; �J���[�R�[�h
		INT		0x10			; �r�f�IBIOS�Ăяo��
		JMP		putloop
FINISH:
		ret
