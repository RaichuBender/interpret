/* recognize tokens for the calculator and print them out */
%{
#include "interpret.tab.h"
%}

%%
"+"				{ return ADD; }
"-"				{ return SUB; }
"*"				{ return MUL; }
"/"				{ return DIV; }
"|"				{ return ABS; }
[0-9]+				{ yylval.num = atoi(yytext); return NUMBER; }
0x[0-9a-fA-F]+		{ yylval.num = strtol(yytext + 2, NULL, 16); return NUMBER; }
0b[01]+			{ yylval.num = strtol(yytext + 2, NULL,  2); return NUMBER; }
[0-9a-zA-Z_ ,.!?]*	{ sprintf(yylval.txt, "%s", yytext); return LITERAL; }
[\"]				{ return QUOT; }
exit\n				{ return EXIT; }
\n					{ return EOL; }
[ \t]				{ /* ignore whitespace */ }
.					{ printf("Mystery character %c\n", *yytext); }
%%

/*
int yylex();

int main(int argc, char **argv)
{
  int tok;

  while(tok = yylex()) {
    printf("%d", tok);
    if(tok == NUMBER) printf(" = %d\n", yylval);
    else printf("\n");
  }
}
*/
