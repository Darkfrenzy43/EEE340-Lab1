
grammar NimbleBrownVelasco;

// TODO - 1. Fix the function expression and statement
//           -> There should be two of these I think


// ------------ Defining Parser Elements --------------

// Creating overarching script parser element
script : func_def* (var* statement*);





// TODO IDK what this is but I don't think this should exist
//<<<<<<< HEAD





var     // keyword
    : 'var' ID ':' TYPE ('=' expre)*
    ;
// TODO IDK what this is but I don't think this should exist
//>>>>>>> 826e5c5a5d1132c4a3bffc66debde7c73d7f6d77

// TODO IDK what this is but I don't think this should exist
//func
    //: ID '()'                      # EmpFunc
    //| ID '(' paramlist ')'         # ParamFunc
    //;


// --------------- Defining Elements for Functions ----------------

// Building function definition from fragments:
// 1. The function name fragment
// 2. The return fragment
// 3. The block fragment

param_frag : ID ':' TYPE;
func_param : param_frag (','param_frag)* ;
func_frag : 'func' ID '(' (func_param)? ')' ;

ret_frag : '->' TYPE ;

block_frag : var* statement* ;

// Building function definition element
func_def: func_frag ret_frag? '{' block_frag '}' ;


// For the function expressions and statements
func : ID '(' (func_args)?  ')' ;
func_args : expre (','expre)* ;


// -------------------- Defining Large Parser Elements --------------------

// Defining key words here too. TODO - still a little confused on keywords
statement
    : ID '=' expre                                               # assigment
    | 'print' WS expre                                           # doPrint
    | 'while' expre '{' ('\n\r')* statement* '}'                 # whileLoop   // Keyword
    | 'if' expre '{' statement* '}' ('else' '{' statement* '}')? # ifElse
    | 'return' expre?                                            # return
    | func                                                       # funcStat
    ;


expre // Add bool and string?
    : '(' expre ')'                  # paren
    | func                           # funcExpre
    | op=('-'|'!') expre             # unibool
    | expre op=('*'|'/') expre       # muldiv
    | expre op=('+'|'-') expre       # addsub
    | expre op=('=='|'<'|'<=') expre # comp
    | LITERAL                        # Literal
    | ID                             # Identifier
    ;

//  ----------- Defining Lexer Elements -------------

// TODO
STRING : ;

LITERAL : NUMBER|STRING|BOOLEAN ;

TYPE : 'Int' | 'String' | 'Bool' ;

NUMBER : [0-9]+;

BOOLEAN : 'true' | 'false';  // keyword

ID : [_A-Za-z][_A-Za-z0-9]*;

COMMENT : '//' ~[\r\n]* -> skip; // ~ means anything but whatever comes after (\r\n is windows version of UNIX's \n)

WS : [ \t\r\n]+ -> skip ; // Though will not be used, making it valid token
