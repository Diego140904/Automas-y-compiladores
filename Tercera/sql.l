%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "struct.h"

int yylex();
int yyerror(const char *msg);

symbtbl *global_symbol_ptr;
%}

%union {
    struct {
        int lineno;
        symbtbl *sym_data;
    };
}

%token <lineno> LINE_END
%token <sym_data> ID CONST_NUM '<' '>' '=' '*' '(' ')'
%token SELECT DELETE INSERT INTO VALUES FROM 
%token JOIN ON WHERE HAVING 
%token ORDER AND OR BY

%type <sym_data> field_list expr comparator comparison_op

%%

input:
      command
    | input command
    | input error
    ;

command:
    select_cmd field_list FROM field_list WHERE expr LINE_END {
        printf(">> Line #: %d\n", $6);
        printf(">> Columns: %s\n", $2);
        printf(">> Table: %s\n\n", $4);
        global_symbol_ptr = putsymb($2, $4, $6);
    }
    ;

field_list:
      '*' { $$ = "ALL"; }
    | ID { $$ = $1; }
    | ID ',' field_list {
        size_t total = strlen($1) + strlen($3) + 2;
        char *merged = (char *)malloc(total);
        snprintf(merged, total, "%s %s", $1, $3);
        $$ = merged;
    }
    ;

select_cmd: SELECT;

insert_cmd: INSERT;

delete_cmd: DELETE;

expr:
      ID comparison_op comparator
    | ID comparison_op comparator logic_op expr
    ;

comparator:
      ID
    | CONST_NUM
    ;

comparison_op:
      '<'
    | '='
    | '>'
    ;

logic_op:
      AND
    | OR
    ;

%%

int yyerror(const char *msg) {
    fprintf(stderr, "[SYNTAX ERROR] %s\n", msg);
    return 1;
}

int main() {
    const char *filename = "results.txt";
    remove(filename);
    yyparse();
    return 0;
}