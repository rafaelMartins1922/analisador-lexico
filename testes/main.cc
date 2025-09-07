#include <stdio.h>

extern "C" int yylex();  

extern char* yytext;

#include "lex.yy.c"

int main() {
  int token = yylex(); // next_token
  
  while( token != 0 ) {
    printf( "%d: [%s]\n", token, yytext );
    token = yylex();
  }
  
  return 0;
}