
grammar sampleTurtle ;

script : statement+ EOF;

statement
  : 'repeat' expr block     # repeat
  | 'set' ID expr           # assignment
  | 'left' expr             # left
  | 'right' expr            # right
  | 'forward' expr          # forward
  | 'backward' expr         # backward
  | 'penup'                 # penup
  | 'pendown'               # pendown
  ;

expr
  : op= ( 'add' | 'subtract' ) expr expr   # addSubtract
  | ID                                     # variable
  | NUMBER                                 # number
  ;

block : '[' statement+ ']' ;

ID : [a-z][a-zA-Z]* ;

NUMBER : [0-9]+ ;

COMMENT : '//' ~[\r\n]* -> skip ;

WS : [ \t\r\n]+ -> skip ;