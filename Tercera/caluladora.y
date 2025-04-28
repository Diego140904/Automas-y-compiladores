%{
    #include<stdio.h>
    int yylex();
    int yyerror(const char *s) {
        fprintf(stderr, "Error: %s\n", s);
        return 0;
    }
%}

%%

%token NUMERO MAS MENOS MULTIPLICACION DIVISION EOL
%start statements;

statements : expression EOL { printf("= %d\n", $1); }

expression : NUMERO { $$ = $1; printf("numero: %d\n", $$); }
           | NUMERO MAS NUMERO { $$ = $1 + $3; printf("SUMA+: %d\n", $$); }
           | NUMERO MENOS NUMERO { $$ = $1 - $3; printf("RESTA-: %d\n", $$); }
           | NUMERO MULTIPLICACION NUMERO { $$ = $1 * $3; printf("MULTIPLICACION*: %d\n", $$); }
           | NUMERO DIVISION NUMERO { 
                if ($3 == 0) {
                    yyerror("Division by zero error");
                    $$ = 0;
                } else {
                    $$ = $1 / $3; 
                    printf("DIVISION/: %d\n", $$); 
                }
           }

%%

int main () {
    yyparse();
    return 1;
}