JMP main

dolzina:
	DB 10	        ; število elementov v seznamu
seznam:
	DB 50	        ; seznam
	DB 56
	DB 60
	DB 46
	DB 44
	DB 58
	DB 42
	DB 52
	DB 48
	DB 54

prazno:
	DB 0

zamenjaj_elementa:	; zamenja vrednosti v mestih, na katera kazeta registra A in B
	PUSH C

	MOV C, [A]
	MOV D, [B]
	MOV [A], D
	MOV [B], C

	POP C
	RET

poisci_minimum:		; poisce minimalni element v seznamu [A:C] in ga shrani v register B
	PUSH A
	PUSH C
	PUSH D

	DEC A
	MOV D, 255

iteracija_minimuma:
	INC A
	CMP A, C
	JAE konec_minimuma

	CMP D, [A]
	JB iteracija_minimuma
	MOV B, A
	MOV D, [A]
	JMP iteracija_minimuma

konec_minimuma:
	POP D
	POP C
	POP A
	RET

uredi:			    ; uredi seznam [A:C]
	PUSH A
	PUSH B
	PUSH C
	PUSH D

	DEC A

iteracija_urejanja:
	INC A
	CMP A, C
	JAE konec_urejanja

	CALL poisci_minimum
	CALL zamenjaj_elementa

	JMP iteracija_urejanja

konec_urejanja:
	POP D
	POP C
	POP B
	POP A
	RET

main:
			        ; pripravimo argumente za funkcijo uredi
	MOV A, seznam	; register A mora kazati na prvi element
	MOV C, seznam	; register C mora kazati na zadnji element + 1
	ADD C, [dolzina]
	CALL uredi	    ; pokličemo funkcijo za urejanje
	HLT		        ; prekinemo izvajanje
