
grammar NimbleBrownVelasco;


// ------------ Defining Parser Elements --------------
script: func* (varDec* statement*);

statement: 'if' expre '{' statement+ '}' ('else' '{' statement+ '}')? # ifelse
          | 'return' expre?
          | func;

// Defining key words here too. TODO - still a little confused on keywords
statement
    : ID '=' expre                            # assigment
    | 'print' WS expre                        # doPrint
    | 'while' expre '{' ('\n\r')* block '}'   # whileLoop   // Keyword
    | func                                    # funcStat
    ;

block
    :
    ;


expre // Add bool and string?
    : '(' expre ')'                  # paren
    | func                           # funcExpre
    | op=('-'|'!') expre             # unibool
    | expre op=('*'|'/') expre       # muldiv
    | expre op=('+'|'-') expre       # addsub
    | expre op=('=='|'<'|'<=') expre # comp
    | (NUMBER|STRING|BOOLEAN)        # Literal
    | ID                             # Identifier
    ;


<<<<<<< HEAD
func: 'func' ID '(' (parameter ',')? ')' ('->' (NUMBER| STRING | BOOLEAN)) '{' varDec* statement*;

parameter: ID ':' (NUMBER | STRING | BOOLEAN);
=======
var     // keyword
    : ID ':' TYPE ('=' expre)*
    ;
>>>>>>> 826e5c5a5d1132c4a3bffc66debde7c73d7f6d77



func
    : ID '()'                      # EmpFunc
    | ID '(' paramlist ')'         # ParamFunc
    ;

paramlist
    : (WS)
    | param
    | (param)(','param)*
    ;

param : WS* expre WS*;

//  ----------- Defining Lexer Elements -------------

// Added
TYPE : 'Int' | 'String' | 'Bool' ;

// Remaining: Keywords, Type names

NUMBER : [0-9]+;

BOOLEAN : 'true' | 'false';  // keyword

// TODO -
STRING : ;


ID : [_A-Za-z][_A-Za-z0-9]*;

COMMENT : '//' ~[\r\n]* -> skip; // ~ means anything but whatever comes after (\r\n is windows version of UNIX's \n)

WS : [ \t\r\n]+ -> skip ; // Though will not be used, making it valid token
