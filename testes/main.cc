#include <stdio.h>

extern int yylex();
extern char* yytext;

int main() {
  int token = yylex(); // next_token
  
  while( token != 0 ) {
    printf( "%d: [%s]\n", token, yytext );
    token = yylex();
  }
  
  return 0;
}