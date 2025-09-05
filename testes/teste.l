D           [0-9]
L           [a-zA-Z_]
NUM         {D}+(\.{D}+)?([Ee][+\-]?{D}+)?

ID          {L}({L}|{D})*

WS          [ \n\r\t]+

%%

{WS}    { }

">="    { lexema = yytext; return MAIOR_IGUAL; }
"<="    { lexema = yytext; return MENOR_IGUAL; }
"=="    { lexema = yytext; return IGUAL; }
"!="    { lexema = yytext; return DIFERENTE; }

"for"   { lexema = yytext; return FOR; }
"int"   { lexema = yytext; return INT; }

{ID}    { lexema = yytext; return ID; }

{NUM}   { lexema = yytext; return NUM; }

.       { lexema = yytext; return yytext[0]; }

%%

int yywrap() {
    return 1;
}