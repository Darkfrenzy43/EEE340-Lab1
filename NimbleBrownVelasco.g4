
grammar NimbleBrownVelasco;


// ------------ Defining Parser Elements --------------

expre // Add bool and string?
    : '(' expre ')'                  # paren
    | op=('-'|'!')expre              # unibool
    | expre op=('*'|'/') expre       # muldiv
    | expre op=('+'|'-') expre       # addsub
    | expre op=('=='|'<'|'<=') expre # comp
    | (NUMBER|STRING|BOOLEAN)        # Literal
    | ID                             # Identifier
    ;

// function calls can return something and also can not. It can thus be an expression (x = fcn()) and statement (fcn())

func
    :
    ;


//  ----------- Defining Lexer Elements -------------

// Remaining: Keywords, Type names

NUMBER : [0-9]+;

BOOLEAN : 'true' | 'false';

// TODO -
STRING : ;

ID : [_A-Za-z][_A-Za-z0-9]*;

COMMENT : '//' ~[\r\n]* -> skip; // ~ means anything but whatever comes after (\r\n is windows version of UNIX's \n)

WS : [ \t\r\n]+ -> skip ; // Though will not be used, making it valid token
