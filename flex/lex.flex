package src.lexer_parser;

import src.lexer_parser.tokens.ColorToken;
import src.lexer_parser.tokens.IdentifierToken;
import src.lexer_parser.tokens.NumberToken;
import src.lexer_parser.tokens.OperatorToken;
import src.lexer_parser.tokens.Token;

%%
%public
%class LexerFlex
%unicode
%type Token
%line
%column

%{
    public Token token(Sym type) {
        return new Token(type);
    }

    public NumberToken token(Sym type, int value) {
        return new NumberToken(type,value);
    }

    public Token token(Sym type, String value) {
        if (type == Sym.IDENTIFIER)
        {
            return new IdentifierToken(type,value);
        }
        else if (type == Sym.OPERATOR)
        {
            return new OperatorToken(type,value);
        }
        else if (type == Sym.COLOR)
        {
            return new ColorToken(type,value);
        }
        System.err.println("SNA parsing in flex");
        return (null);
    }
%}

%yylexthrow{
	Exception, LexerException
%yylexthrow}

number = [0-9]+
string = [a-z][a-zA-Z_]*
blank = "\n" | "\r" | " " | "\t" | "\v" | "\f" 
operator = "+" | "-" | "*" | "/"
hex = [0-9A-F]
color = #{hex}{hex}{hex}{hex}{hex}{hex}

%%
{number}    		{return token(Sym.NUMBER,Integer.parseInt(yytext()));}
{color}				{return token(Sym.COLOR,yytext());}
{operator}			{return token(Sym.OPERATOR,yytext());}
{string}			{return token(Sym.IDENTIFIER, yytext());}
","					{return token(Sym.COMMA);}
";"					{return token(Sym.SEMICOLON);}
"("             	{return token(Sym.LPAR);}
")"                 {return token(Sym.RPAR);}
"Begin"				{return token(Sym.BEGIN);}
"End"				{return token(Sym.END);}
"While"				{return token(Sym.WHILE);}
"Do"				{return token(Sym.DO);}
"Done"				{return token(Sym.DONE);}
"If"	            {return token(Sym.IF);}
"Elif"      		{return token(Sym.ELIF);}
"Then"      		{return token(Sym.THEN);}
"Else"      		{return token(Sym.ELSE);}
"Const"				{return token(Sym.CONST);}
"Var"				{return token(Sym.VAR);}
"="					{return token(Sym.EQUALS);}
"DrawCircle"		{return token(Sym.DRAWCIRCLE);}
"FillCircle"		{return token(Sym.FILLCIRCLE);}
"DrawRect"			{return token(Sym.DRAWRECT);}
"FillRect"			{return token(Sym.FILLRECT);}
{blank}     		{}
[^]		            {throw new LexerException(yytext(), yyline, yycolumn);}