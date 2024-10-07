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
	DB 54

minimum:
	DB 0	; na koncu bo tu minimum

poisci_minimum:
	PUSH A
	PUSH C
	PUSH D

	DEC A
	MOV D, 255

zanka_funkcije:
	INC A
	CMP A, C
	JAE konec_funkcije
	CMP D, [A]
	JB zanka_funkcije
	MOV B, A
	MOV D, [A]
	JMP zanka_funkcije

konec_funkcije:
	POP D
	POP C
	POP A
	RET

main:
	; pripravimo parametre funkcije
	MOV A, seznam
	MOV C, seznam
	ADD C, [dolzina]
	; pokličemo funkcijo
	CALL poisci_minimum
	; v mesto, na katerega kaže minimum, shranimo vrednost, na katero kaže B
	; ker tega ne moremo narediti direktno, si pomagamo z registrom C
	PUSH C 
	MOV C, [B]
	MOV [minimum], C
	POP C
	HLT
