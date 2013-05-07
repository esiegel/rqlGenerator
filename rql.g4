grammar rql;

program  
 : EOF
 | query (BOOLOP_SHORT query)* EOF
 ;

query
 : query_fragment
 | OPAR query_fragment CPAR 
 | 'and' OPAR query COMMA query (COMMA query)* CPAR
 | 'or' OPAR query COMMA query (COMMA query)* CPAR
 ;

query_fragment
 : 'count' OPAR CPAR
 | 'distinct' OPAR CPAR
 | 'eq' OPAR ID COMMA VALUE CPAR
 | 'first' OPAR CPAR
 | 'ge' OPAR ID COMMA VALUE CPAR
 | 'gt' OPAR ID COMMA VALUE CPAR
 | 'in' OPAR ID COMMA VALUE_ARRAY CPAR
 | 'le' OPAR ID COMMA VALUE CPAR
 | 'limit' OPAR INT CPAR
 | 'ne' OPAR ID COMMA VALUE CPAR
 | 'select' OPAR ID (COMMA ID)* CPAR
 | 'sort' OPAR SORT_ORDER ID CPAR
 ;

VALUE
 : STRING
 | INT
 | FLOAT
 ;

SORT_ORDER
 : PLUS
 | MINUS
 ;

VALUE_ARRAY
 : OBRK VALUE* CBRK
 ;

BOOLOP_SHORT 
 : '&' 
 | '|'
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
