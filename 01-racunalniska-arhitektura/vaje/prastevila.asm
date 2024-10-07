JMP main

ostanek:		; v C shrani ostanek pri deljenju A z B
	PUSH A

	MOV C, A
	DIV B
	MUL B
	SUB C, A

	POP A
	RET

prastevilcnost:		; v D shrani, ali je A prastevilo
	MOV B, 2
	MOV D, 1

zanka_prastevilcnosti:
	PUSH A
	MOV A, B
	MUL B
	MOV C, A
	POP A

	CMP C, A
	JA konec_prastevilcnosti

	CALL ostanek
	CMP C, 0
	JE ni_prastevilo

	INC B
	JMP zanka_prastevilcnosti

ni_prastevilo:
	MOV D, 0

konec_prastevilcnosti:
	RET

main:
	MOV A, 1

zanka_stevil:
	INC A

	CALL prastevilcnost
	CMP D, 0
	JE zanka_stevil

dodaj_stevilo:
	PUSH A
	JMP zanka_stevil
