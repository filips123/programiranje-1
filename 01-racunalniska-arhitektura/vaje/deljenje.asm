MOV A, 10
MOV B, 6

loop:
	CMP A, B
	JB end
	SUB A, B
	JMP loop

end:
	HLT
