// submitted by OCdt Velasco and OCdt Brown
grammar NimbleBrownVelasco;



// ----------------- Defining Parser Elements -------------------

// Creating overarching script parser element
script : func_def* (var* statement*);


// ------ Defining Elements for Functions --------

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


// ------------------ Defining Statement Fragments -----------------------

stat_block_frag : '{' ('\n\r')* statement* '}'  ;
if_frag : 'if' expre stat_block_frag;
else_frag : 'else' stat_block_frag;


var : 'var' ID ':' TYPE ('=' expre)* ; // Double check this

// -------------------- Defining Large Parser Elements --------------------

// Defining key words here too. TODO - still a little confused on keywords
statement
    : ID '=' expre                                       # assigment
    | 'print' expre                                      # doPrint
    | 'while' expre stat_block_frag                      # whileLoop   // Keyword
    | if_frag (else_frag)?                               # ifElse
    | 'return' expre?                                    # return
    | func                                               # funcStat
    ;


expre
    : '(' expre ')'                  # paren
    | func                           # funcExpre
    | op=('-'|'!') expre             # unibool
    | expre op=('*'|'/') expre       # muldiv
    | expre op=('+'|'-') expre       # addsub
    | expre op=('=='|'<'|'<=') expre # compare
    | (NUMBER|STRING|BOOLEAN)        # Literal
    | ID                             # Identifier
    ;


//  ----------- Defining Lexer Elements -------------

TYPE : 'Int' | 'String' | 'Bool' ;
ID : [_A-Za-z][_A-Za-z0-9]*;
NUMBER : [0-9]+;
BOOLEAN : 'true' | 'false';  // keyword

// ---- Building the string from fragments ----
ASC_FRAG : ((' '..'[')|(']'..'~')) -> skip; // skip included so it doesn't detect an ASC_FRAG whenever there is no string
SLASH_FRAG :   '\\' [ \\abfnrtv'"?] ;
STRING : '"' (ASC_FRAG|SLASH_FRAG)*? '"';


COMMENT : '//' ~[\r\n]* -> skip; // ~ means anything but whatever comes after (\r\n is windows version of UNIX's \n)
WS : [ \t\r\n]+ -> skip ; // Though will not be used, making it valid token



