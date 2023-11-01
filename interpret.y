/* simplest version of calculator */
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
int yyerror(char *s);
%}

/* declare tokens */
%token <num> NUMBER
%token <txt> LITERAL
%token ADD SUB MUL DIV ABS
%token QUOT
%token EXIT EOL

%type <num> term factor exp calclist
%type <txt> string valid

%union {
  int num;
  char txt [1024];
}

%%

interpret:
 | EXIT { printf("Good Bye!\n\n"); exit(0); }
 | valid EOL { printf("%s\nOK\n\n", $1); }
 | interpret interpret
 ;

valid:
 | exp { sprintf($$, "= %d", $1); }
 | string { sprintf($$, "$ %s", $1); }
 | string ADD valid { sprintf($$, "%s\t%s", $1, $3); }
 ;

string:
 | QUOT LITERAL QUOT { sprintf($$, "%s", $2); }
 | string ADD string { sprintf($$, "%s\t%s", $1, $3); }
 ;

exp: factor      // default $$ = $1
 | exp ADD factor { $$ = $1 + $3; }
 | exp SUB factor { $$ = $1 - $3; }
 ;

factor: term      // default $$ = $1
 | factor MUL term { $$ = $1 * $3; }
 | factor DIV term { $$ = $1 / $3; }
 ;

term: NUMBER // default $$ = $1
 | ABS term   { $$ = $2 >= 0? $2 : - $2; }
 ;

%%

int main(int argc, char **argv)
{
  yyparse();
}

int yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}
