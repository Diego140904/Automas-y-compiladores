%{
    #include<stdio.h>
    extern int yylval;
%}

%%

[0-9]+        { yylval = atoi(yytext); return NUMERO; }
"+"           { return MAS; }
"-"           { return MENOS; }
"*"           { return MULTIPLICACION; }
"/"           { return DIVISION; }
\n            { return EOL; }
[ \t\n\r]      {}

%%

int yywrap(void) {
    return 1;
}