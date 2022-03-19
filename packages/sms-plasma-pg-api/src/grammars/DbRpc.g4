grammar DbRpc;

import DbCommon;

// Main rule, representing the http request
request: path (QuestionMark query)?;

// Concatenate schema and function name, like '/public/fn1'
path: Slash schema = name Slash fn = name;

// Query is what follows the ? in request (collection of parameters)
query: param (Ampersand param)*;

// A param should not appear more than once, but this will be checked in rule exit method
param: args | format;
