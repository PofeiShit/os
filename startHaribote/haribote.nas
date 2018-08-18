; haribote-os
; TAB=4

		ORG		0x8400	; このプログラムがどこに読み込まれるのか
		MOV		SI, msg
		call 		putloop
		MOV		AL,0x13			; VGAグラフィックス、320x200x8bitカラー
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
		ADD		SI,1			; SIに1を足す
		CMP		AL,0
		JE		FINISH	
		MOV		AH,0x0e			; 一文字表示ファンクション
		MOV		BX,15			; カラーコード
		INT		0x10			; ビデオBIOS呼び出し
		JMP		putloop
FINISH:
		ret
