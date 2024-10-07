JMP main

dolzina:
	DB 10	; število elementov v seznamu

seznam:
	DB 50	; seznam
	DB 56
	DB 60
	DB 46
	DB 44
	DB 58
	DB 42
	DB 52
	DB 48
	DB 5

minimum:
    DB 0	; na koncu bo tu minimum

main:
	MOV [minimum], 255
	MOV C, seznam
	ADD C, [dolzina]
	MOV B, seznam

loop:
	MOV A, [minimum]
	CMP A, [B]
	JB nextiter
	MOV A, [B]
	MOV [minimum], A
	JMP nextiter

nextiter:
	INC B
	CMP B, C
	JBE loop

end:
	HLT
