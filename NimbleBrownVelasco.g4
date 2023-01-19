
grammar NimbleBrownVelasco;


// ------------ Defining Parser Elements --------------

expre
    : op=('-'|'!')expre              # unibool
    | expre op=('*'|'/') expre       # muldiv
    | expre op=('+'|'-') expre       # addsub
    | expre op=('=='|'<'|'<=') expre # comp
    ;




//  ----------- Defining Lexer Elements -------------

// Reminaing: Keywords, Type names





ID : [_A-Za-z][_A-Za-z0-9]*;

COMMENT : '//' ~[\r\n]* -> skip; // ~ means anything but whatever comes after (\r\n is windows version of UNIX's \n)

WS : [ \t\r\n]+ -> skip ; // Though will not be used, making it valid token
