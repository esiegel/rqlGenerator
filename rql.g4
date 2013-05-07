grammar rql;

program  
 : EOF
 | query (BOOLOP_SHORT query)* EOF
 ;

query 
 : fragment
 | LPAREN fragment RPAREN 
 | 'and' LPAREN query COMMA query (COMMA query)* RPAREN
 | 'or' LPAREN query COMMA query (COMMA query)* RPAREN
 ;

fragment
 | 'count' LPAREN RPAREN
 | 'distinct' LPAREN RPAREN
 | 'eq' LPAREN ID COMMA VALUE RPAREN
 | 'first' LPAREN RPAREN
 | 'ge' LPAREN ID COMMA VALUE RPAREN
 | 'gt' LPAREN ID COMMA VALUE RPAREN
 | 'in' LPAREN ID COMMA VALUE_ARRAY RPAREN
 | 'le' LPAREN ID COMMA VALUE RPAREN
 | 'limit' LPAREN INT RPAREN
 | 'ne' LPAREN ID COMMA VALUE RPAREN
 | 'select' LPAREN ID (COMMA ID)* RPAREN
 | 'sort' LPAREN SORT_ORDER ID RPAREN
 ;

VALUE
 | STRING
 | INT
 | FLOAT
 ;

SORT_ORDER
 | PLUS
 | MINUS
 ;

VALUE_ARRAY
 | OBRK VALUE* CBRK
 ;

BOOLOP_SHORT 
 : '&' 
 | '|'
 ;

assignment
 : ID ASSIGN expr SCOL
 ;

if_stat
 : IF condition_block (ELSE IF condition_block)* (ELSE stat_block)?
 ;

condition_block
 : expr stat_block
 ;

stat_block
 : OBRACE block CBRACE
 | stat
 ;

while_stat
 : WHILE expr stat_block
 ;

log
 : LOG expr SCOL
 ;

expr
 : expr POW<assoc=right> expr #powExpr
 | MINUS expr                 #unaryMinusExpr
 | expr MOD expr              #modExpr
 | expr MULT expr             #multExpr
 | expr DIV expr              #divExpr
 | expr PLUS expr             #plusExpr
 | expr MINUS expr            #minusExpr
 | expr LTEQ expr             #lteqExpr
 | expr GTEQ expr             #gteqExpr
 | expr LT expr               #ltExpr
 | expr GT expr               #gtExpr
 | expr NEQ expr              #neqExpr
 | expr EQ expr               #eqExpr
 | expr AND expr              #andExpr
 | expr OR expr               #orExpr
 | atom                       #atomExpr
 ;

atom
 : OPAR expr CPAR #parExpr
 | (INT | FLOAT)  #numberAtom
 | (TRUE | FALSE) #booleanAtom
 | ID             #idAtom
 | STRING         #stringAtom
 | NIL            #nilAtom
 ;

OR : '||';
AND : '&&';
EQ : '==';
NEQ : '!=';
GT : '>';
LT : '<';
GTEQ : '>=';
LTEQ : '<=';
PLUS : '+';
MINUS : '-';
ASSIGN : '=';
OBRK : '[';
CBRK : ']';
OPAR : '(';
CPAR : ')';
COMMA : ',';

TRUE : 'true';
FALSE : 'false';

ID
 : [a-zA-Z_] [a-zA-Z_0-9]*
 ;


INT
 : [0-9]+
 ;

FLOAT
 : [0-9]+ '.' [0-9]* 
 | '.' [0-9]+
 ;

SPACE
 : [ \t\r\n] -> skip
 ;

STRING
 : '"' (~["\r\n] | '""')* '"'
 ;

OTHER
 : . 
 ;
