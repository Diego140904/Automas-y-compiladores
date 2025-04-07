%option noyywrap 

%{
#include <stdio.h>

extern FILE *yyin;

int cont_lineas = 0; 
int cont_palabras = 0; 
int cont_caracteres = 0; 
int cont_ni = 0; 
int cont_num = 0;
int cont_b_to = 0; 
int cont_jo = 0;
int cont_digitos = 0; 

%}

%%

\n				{ cont_lineas++; } 
[a-zA-Záéíóúñ]+			{ cont_palabras++; cont_caracteres+= yyleng; } 
.				{ cont_caracteres++; }  
[nN][iI][a-zA-Záéíóúñ]*		{ cont_ni++; cont_palabras++; cont_caracteres+= yyleng; }
[nN][uUúÚ][mM][a-zA-Záéíóúñ]*	{ cont_num++; cont_palabras++; cont_caracteres+= yyleng; }
[b][a-zA-Záéíóúñ]*[tT][oO]	{ cont_b_to++; cont_palabras++; cont_caracteres+= yyleng; }
[a-zA-Záéíóúñ]*[jJ][oO]		{ cont_jo++; cont_palabras++; cont_caracteres+= yyleng; }
[0-9]+				{ cont_digitos++; cont_caracteres+= yyleng; }


%%

int main(int argc, char **argv){
    if(argc > 1){
        FILE *file = fopen(argv[1], "r");
        if(!file){
            perror("No se pudo abrir el archivo");
            return 1;
        }
        yyin = file;
    }

    yylex();

    printf("\nTotal de Lineas: %d\n", cont_lineas); 
    printf("Total de Palabras: %d\n", cont_palabras); 
    printf("Total de Caracteres: %d\n", cont_caracteres); 
    printf("\Total de palabras que inician con NI: %d\n", cont_ni); 
    printf("Total de palabras que inician con NUM: %d\n", cont_num);
    printf("Total de palabras que inician con B y terminan con TO: %d\n", cont_b_to); 
    printf("Total de palabras que terminan con JO: %d\n", cont_jo);
    printf("Total de digitos: %d\n", cont_digitos);     

    if(argc > 1){
        fclose(yyin);
    }

    return 0;
}
