%{
#include <stdio.h>
#include <string.h>
#include "struct.h"
#include "y.tab.h"

int current_line = 0;
%}

%option noyywrap

%%

"select"            return SELECT;
"delete"            return DELETE;
"insert"            return INSERT;
"into"              return INTO;
"values"            return VALUES;
"from"              return FROM;
"join"              return JOIN;
"on"                return ON;
"where"             return WHERE;
"having"            return HAVING;
"order"             return ORDER;
"by"                return BY;
"and"               return AND;
"or"                return OR;

"*"                 return '*';
","                 return ',';
"="                 return '=';
"<"                 return '<';
">"                 return '>';
"("                 return '(';
")"                 return ')';

[a-zA-Z][a-zA-Z0-9]* {
                        yylval.symbol_data = strdup(yytext);
                        return ID;
                    }

[0-9]+ {
                        yylval.symbol_data = strdup(yytext); // numérico tratado como símbolo también
                        return CONST_NUM;
                    }

\n {
    yylval.line_number = ++current_line;
    return LINE_END;
}

[ \t\r]+            /* ignorar espacios en blanco */

.                   /* ignorar cualquier otro carácter inesperado */

%%