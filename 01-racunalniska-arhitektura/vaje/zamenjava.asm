MOV A, 69
MOV [A], 42

MOV B, 96
MOV [B], 24

MOV C, [A]
MOV D, [B]
MOV [A], D
MOV [B], C

HLT
