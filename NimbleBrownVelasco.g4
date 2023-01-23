
grammar NimbleBrownVelasco;


// ------------ Defining Parser Elements --------------
script: func* (var* statement*);

// Defining key words here too. TODO - still a little confused on keywords
statement
    : ID '=' expre                                               # assigment
    | 'print' WS expre                                           # doPrint
    | 'while' expre '{' ('\n\r')* block '}'                      # whileLoop   // Keyword
    | 'if' expre '{' statement+ '}' ('else' '{' statement+ '}')? # ifelse
    | 'return' expre?                                            # return
    | func                                                       # funcStat
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


// TODO IDK what this is but I don't think this should exist
//<<<<<<< HEAD
func: 'func' ID '(' (parameter ',')? ')' ('->' (NUMBER| STRING | BOOLEAN)) '{' var* statement*;

parameter: ID ':' (NUMBER | STRING | BOOLEAN);
// TODO IDK what this is but I don't think this should exist
//=======
var     // keyword
    : ID ':' TYPE ('=' expre)*
    ;
// TODO IDK what this is but I don't think this should exist
//>>>>>>> 826e5c5a5d1132c4a3bffc66debde7c73d7f6d77

// TODO IDK what this is but I don't think this should exist
//func
    //: ID '()'                      # EmpFunc
    //| ID '(' paramlist ')'         # ParamFunc
    //;

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
