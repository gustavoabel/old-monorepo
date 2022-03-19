grammar DbQuery;

import DbCommon;

// Main rule, representing the http request
request: path QuestionMark query;

// Concatenate schema and table, like '/olap/costing'
path: Slash schema = name Slash baseTable = table;

// Optionally aliased name of the table, like 'c:costing'
table: (aliasName = stringLiteral Colon)? (schemaName = name Dot)? tableName = name;

// Query is what follows the ? in request (collection of parameters)
query: param (Ampersand param)*;

// A param should not appear more than once, but this will be checked in rule exit method
param:
	include
	| select
	| where
	| groupBy
	| orderBy
	| args
  | limit
	| format;

// From clause, defining other tables involved in the query (besides the one in 'path')
include: INCLUDE Equals includeTable (Comma includeTable)*;

// Joined table, like in 'p:parameter[id=formula_id]'. It is possible to have nested includeTables (joining of n tables)
includeTable:
	included = table LSquare (inColumn = column Equals outColumn = column | joinFilter = joinClause) (Comma joinType = joinOption)? RSquare (
		LParenthesis includeTable RParenthesis
	)*;

// Join option
joinOption: LEFT | RIGHT | INNER | FULL;

// Select clause, defining the columns to be returned in query. It is a csv of selectElements
select: SELECT Equals selectElementList | selectDistinct;

selectElementList: selectElement (Comma selectElement)*;

selectDistinct:
	SELECT Equals DISTINCT LParenthesis selectElementList RParenthesis;

// Select names might be aliased. Options are column names, function calls or expressions
selectElement: (aliasName = stringLiteral Colon)? el = expression (
		LSquare part = tsPart RSquare
	)?;

groupBy: GROUPBY Equals groupByValue (Comma groupByValue)*;

groupByValue: decimalLiteral;

orderBy: ORDERBY Equals orderByValue (Comma orderByValue)*;

orderByValue: decimalLiteral;

limit: LIMIT Equals val = decimalLiteral;

tsPart:
	SECOND
	| MINUTE
	| HOUR
	| DAY
	| WEEK
	| MONTH
	| QUARTER
	| YEAR;
