
/*

    Authors: OCdt Brown and OCdt Velasco


    Major lessons learned:

    - Order of the lexer and parser elements does in fact matter!
    For example, if we had defined the ASC_FRAG lexer element before the NUMBER and ID elements,
    ANTLR would initally read any inputted single digit number or single character as an ASC_FRAG, and
    not the latter two elements. Thus, they would never be registered as NUMBERs or IDs, but rather ASC_FRAG as a part
    of an entire string.

    TLDR: ASC_FRAG was block the functioning of NUMBER and ID.

*/


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

var : 'var' ID ':' TYPE ('=' expre)* ; // Should be ? instead of *

// -------------------- Defining Large Parser Elements --------------------

statement
    : ID '=' expre                      # assigment
    | 'print' expre                     # doPrint
    | 'while' expre stat_block_frag     # whileLoop
    | if_frag (else_frag)?              # ifElse
    | 'return' expre?                   # return
    | func                              # funcStat
    ;

expre
    : '(' expre ')'                      # paren
    | func                               # funcExpre
    | op=('-'|'!') expre                 # unibool
    | expre op=('*'|'/') expre           # muldiv
    | expre op=('+'|'-') expre           # addsub
    | expre op=('=='|'<'|'<=') expre     # compare
    | (NUMBER|STRING|BOOLEAN)            # Literal
    | ID                                 # Identifier
    ;


//  ----------- Defining Lexer Elements -------------

TYPE : 'Int' | 'String' | 'Bool' ;
BOOLEAN : 'true' | 'false';  // SHOULD BE DEFINED UP HERE
ID : [_A-Za-z][_A-Za-z0-9]*;
NUMBER : [0-9]+;


// ---- Building the string from fragments ----
ASC_FRAG : ((' '..'[')|(']'..'~')) -> skip; // skip included so it doesn't detect an ASC_FRAG whenever there is no string
fragment SLASH_FRAG :   '\\' [\\abfnrtv'"?] ; // Changed into fragment
fragment STRING : '"' (ASC_FRAG|SLASH_FRAG)*?  '"'; // Added fragments here


COMMENT : '//' ~[\r\n]* -> skip; // ~ means anything but whatever comes after (\r\n is windows version of UNIX's \n)
WS : [ \t\r\n]+ -> skip ; // Though will not be used, making it valid token



