%{
	#include<stdio.h>
	#include<stdlib.h>
%}

%token <num> NUMBER
%token MULT
%type <num> expr

%union { 
	int num;
}


%%

input:
    expr '\n' { printf("Resultado valido: %d\n", $1); }
  ;

expr:
    NUMBER MULT NUMBER { $$ = $1 * $3; }
  ;

%%

int yyerror(const char *msg) {
    fprintf(stderr, "Error de sintaxis: %s\n", msg);
    return 1;
}

int main()
{
	printf("Introduce una multiplicacion:\n");
	yyparse();
	return 0;
}