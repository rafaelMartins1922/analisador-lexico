%{
#include <iostream>

using namespace std;

string lexema;
             
%}

/* Definições regulares */
WS      [ \n\r\t]
ID      \$?[a-zA-Z_][a-zA-Z0-9_]*
LINECMT "//"([^\/\n]|\/[^*])+
BLOCKCMT "/*"([^*]|\*+[^/])*\*+"/"

STRING2_NO_ID "`"([^$\n]|\$[^{]|\s+\n)*\$?"`"

EXPR "\${"{ID}"}"

STRING2_END ([^$\n{}]|\s+\n)+"`"

STRING2_START "`"([^$\n{}]|\s+\n)+


%x double_quote_str
%x single_quote_str
%x single_line_comment
%x multi_line_comment

%%

{WS}          { /* ignora espaços, tabs e '\n' */ }

{ID}    { lexema = yytext; return _ID; }

\"  {
    BEGIN(double_quote_str);
    lexema = ""; 
}

<double_quote_str>{
    \\\"   {
        lexema += "\"";
    }

    \"\"  {
        lexema += "\"";
    }

    [^\"\n\\]+  {
        lexema += yytext;
    }
    
    \"  {
            BEGIN(INITIAL);
            return _STRING;
    }
}

\'  {
    BEGIN(single_quote_str);
    lexema = ""; 
}

<single_quote_str>{
    \\\'   {
        lexema += "\'";
    }

    \'\'  {
        lexema += "\'";
    }

    [^\'\n\\]+  {
        lexema += yytext;
    }
    
    \'  {
            BEGIN(INITIAL);
            return _STRING;
    }
}

\/\/         {
    BEGIN(single_line_comment);
    lexema = ""; 
}

<single_line_comment>{
    [^\n\/]+  {
        lexema += yytext;
    }

    \/[^\*]  {
        lexema += yytext;
    }

    \/\*         {
        BEGIN(multi_line_comment);
        lexema = ""; 
    }

    \n  {
            BEGIN(INITIAL);
            return _COMENTARIO;
    }  

    <<EOF>>  {
            BEGIN(INITIAL);
            return _COMENTARIO;
    }
}

\/\*         {
    BEGIN(multi_line_comment);
    lexema = ""; 
}

<multi_line_comment>{
    [^\*]  {
        lexema += yytext;
    }

    \*[^\/]  {
        lexema += yytext;
    }

    \*\/  {
            BEGIN(INITIAL);
            return _COMENTARIO;
    }  

    <<EOF>>  {
            BEGIN(INITIAL);
            return _COMENTARIO;
    }
}

.             { return *yytext; 
                /* Qualquer caractere isolado */ }

%%

/* Não coloque nada aqui - a função main é automaticamente incluída na hora de avaliar e dar a nota. */