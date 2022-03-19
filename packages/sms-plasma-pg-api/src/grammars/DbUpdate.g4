grammar DbUpdate;

import DbCommon;

// Main rule, representing the http request
request: path QuestionMark query;

// Concatenate schema and table, like '/olap/costing'
path: Slash schema = name Slash baseTable = table;

// Optionally aliased name of the table, like 'c:costing'
table: (aliasName = stringLiteral Colon)? tableName = name;

// Query is what follows the ? in request (collection of parameters)
query: where (Ampersand param)*;

// A param should not appear more than once, but this will be checked in rule exit method
param: returning | args | format | beginTransaction | resultName | transactionItem | commitTransaction;
