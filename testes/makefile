all: saida entrada.txt
	./saida < entrada.txt

lex.yy.c: teste.l
	lex teste.l

saida: lex.yy.c main.cc 
	g++ lex.yy.c main.cc -o saida -lfl
	
clean:
	rm saida lex.yy.c