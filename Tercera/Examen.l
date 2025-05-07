%option noyywrap
%{
	#include "y.tab.h"
%}

%%

[0-9]+     { yylval.num = atoi(yytext); return NUMBER; }
[\*]       { return MULT; }
\n	   { return '\n'; }
[ \t\r]+    ; 
.          { return yytext[0]; }  

%%