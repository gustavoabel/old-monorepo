grammar DbCommon;

/* Characters ---------------------------------------------------------------*/

fragment A: ('a' | 'A');
fragment B: ('b' | 'B');
fragment C: ('c' | 'C');
fragment D: ('d' | 'D');
fragment E: ('e' | 'E');
fragment F: ('f' | 'F');
fragment G: ('g' | 'G');
fragment H: ('h' | 'H');
fragment I: ('i' | 'I');
fragment J: ('j' | 'J');
fragment K: ('k' | 'K');
fragment L: ('l' | 'L');
fragment M: ('m' | 'M');
fragment N: ('n' | 'N');
fragment O: ('o' | 'O');
fragment P: ('p' | 'P');
fragment Q: ('q' | 'Q');
fragment R: ('r' | 'R');
fragment S: ('s' | 'S');
fragment T: ('t' | 'T');
fragment U: ('u' | 'U');
fragment V: ('v' | 'V');
fragment W: ('w' | 'W');
fragment X: ('x' | 'X');
fragment Y: ('y' | 'Y');
fragment Z: ('z' | 'Z');

/* Symbols ------------------------------------------------------------------*/

Slash: '/';
QuestionMark: '?';
ExclamationMark: '!';
Ampersand: '&';
Dot: '.';
Comma: ',';
Colon: ':';
Equals: '=';
At: '@';
LCurly: '{';
RCurly: '}';
LSquare: '[';
RSquare: ']';
LParenthesis: '(';
RParenthesis: ')';
Minus: '-';
DollarSign: '$';
Arrow: '->';

/* Keywords -----------------------------------------------------------------*/

SELECT: S E L E C T;
DISTINCT: D I S T I N C T;
INCLUDE: I N C L U D E;
WHERE: W H E R E;
GROUPBY: G R O U P B Y;
ORDERBY: O R D E R B Y;
ARGS: A R G S;
FORMAT: F O R M A T;
NOT: N O T;
AVG: A V G;
MAX: M A X;
MIN: M I N;
SUM: S U M;
AND: A N D;
OR: O R;
TRUE: T R U E;
FALSE: F A L S E;
CSV: C S V;
JSON: J S O N;
SECOND: S E C O N D;
MINUTE: M I N U T E;
HOUR: H O U R;
DAY: D A Y;
WEEK: W E E K;
MONTH: M O N T H;
QUARTER: Q U A R T E R;
YEAR: Y E A R;
RETURNING: R E T U R N I N G;
NONE: N O N E;
COUNT: C O U N T;
ROWS: R O W S;
LEFT:L E F T ;
RIGHT: R I G H T;
INNER: I N N E R;
FULL: F U L L;
BEGIN: B E G I N;
COMMIT: C O M M I T;
RESNAME: R E S N A M E;
TXID: T X I D;
NULL: N U L L;
ISNULL: I S N U L L;
ISNOTNULL: I S N O T N U L L;
LIMIT: L I M I T;

/* Other lexer rules --------------------------------------------------------*/

IDENTIFIER: [a-zA-Z_] [a-zA-Z_0-9]*;
REAL_LITERAL: (DIGIT+ '.' DIGIT+ | DIGIT+ '.' | '.' DIGIT+);
DECIMAL_LITERAL: DIGIT+;
DIGIT: [0-9];
STRING: '\'' ('\\"' | '\u0025' | ~[\u0027\r\n])* '\'';
WS: (' ' | '\t' | '\r' | '\n') -> skip;

/* Parser rules -------------------------------------------------------------*/

// Format of the return
format: FORMAT Equals (CSV | JSON);

// Constants, literals
constant:
	booleanLiteral
	| stringLiteral
	| decimalLiteral
	| realLiteral
  | nullLiteral;

// True or false
booleanLiteral: TRUE | FALSE;

// Single quoted text
stringLiteral: STRING;

// Decimal (integers)
decimalLiteral: DECIMAL_LITERAL;

// Real
realLiteral: REAL_LITERAL;

// Null
nullLiteral: NULL;

// generic names: alpha, digital and underscore, starting with alpha
name: IDENTIFIER;

// Where clause, defining filters in the query
where: WHERE Equals whereClause;

// Individual where clauses or filters
whereClause:
	constant
	| logicalExpression
	| notExpression
  | nullExpression
	| comparisonExpression;

// Individual join clauses or filters
joinClause:
	constant
	| logicalExpression
	| notExpression
  | nullExpression
	| comparisonExpression;

// Expressions
expression:
	expressionAtom
	| logicalExpression
	| notExpression
	| comparisonExpression
	| mathExpression
	| unaryExpression
  | nullExpression
	| parenthesisExpression;

expressionAtom:
	column
	| constant
	| constantList
	| functionCall
	| argKey;

// Column name prefixed with table name
column: (tableAlias = stringLiteral Dot)? colName = columnName;

// Column name is a simple name or a arrowed name (in case of hstore or flat json types)
columnName:
	name
	| name Arrow stringLiteral
	| name LSquare decimalLiteral RSquare;

// Function calls
functionCall:
	fn = (AVG | MAX | MIN | SUM) LParenthesis fnArg = functionArg RParenthesis;

// Function call arguments
functionArg: constant | column | expression;

argKey: DollarSign decimalLiteral;

logicalExpression:
	op = logicalOperator LParenthesis exp = expression (
		Comma expression
	)* RParenthesis;

notExpression: NOT LParenthesis exp = expression RParenthesis;

comparisonExpression:
	left = expressionAtom op = comparisonOrLtreeOperator right = expressionAtom;

mathExpression:
	left = expressionAtom op = mathOperator right = expressionAtom;

unaryExpression: op = unaryOperator exp = expressionAtom;

nullExpression: op = nullOperator LParenthesis exp = expressionAtom RParenthesis;

parenthesisExpression:
	LParenthesis exp = expression RParenthesis;

comparisonOrLtreeOperator: comparisonOperator | ltreeOperator;

ltreeOperator:
  '@' '>'
  | '<' '@';

comparisonOperator:
	'='
	| '>'
	| '<'
	| '<' '='
	| '>' '='
	| '!' '='
	| '~'
	| '.';

mathOperator: '*' | '/' | '+' | '-';

unaryOperator: '-' | '+' | '!';

nullOperator: ISNULL | ISNOTNULL;

logicalOperator: AND | OR;

args: ARGS Equals argValue (Comma argValue)*;

argValue: constant | argArray;

argArray: LSquare constant (Comma constant)* RSquare;

returning: RETURNING Equals returningOption;

returningOption:
	NONE
	| COUNT
	| ROWS (
		LParenthesis columnName (Comma columnName)* RParenthesis
	)?;

constantList:
	LParenthesis booleanLiteral (Comma booleanLiteral)* RParenthesis
	| LParenthesis stringLiteral (Comma stringLiteral)* RParenthesis
	| LParenthesis decimalLiteral (Comma decimalLiteral)* RParenthesis
	| LParenthesis realLiteral (Comma realLiteral)* RParenthesis;


// Transaction uuid
uuid: stringLiteral;

// Indicates the beginning of a transaction
beginTransaction: BEGIN Equals uuid;

// Name of query execution result
resultName: RESNAME Equals IDENTIFIER;

// Intermediary query
transactionItem: TXID Equals uuid;

// Indicates the end of a transaction
commitTransaction: COMMIT Equals uuid;
