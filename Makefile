interpret:	interpret.tab.o lex.yy.o
	$(CC) $^ -lfl -o $@

interpret.tab.o:	interpret.y
	bison -d $^
	$(CC) interpret.tab.c -c -o $@

lex.yy.o:			interpret.l
	flex interpret.l
	$(CC) lex.yy.c -c -o $@

.PHONY:		clean
clean:
	-rm -v interpret interpret.tab.o lex.yy.o interpret.tab.c interpret.tab.h lex.yy.c
