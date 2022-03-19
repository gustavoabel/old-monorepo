import { Handler } from '@sms/plasma-nodejs-api';

const handlers: Handler[] = [
  {
    endpoint: 'rpc',
    method: 'GET',
    lexer: require('./grammars/DbRpcLexer').DbRpcLexer,
    parser: require('./grammars/DbRpcParser').DbRpcParser,
    visitor: require('./visitors/rpc').Visitor,
    reducer: require('./reducer').Reducer,
  },
  {
    endpoint: 'query',
    method: 'GET',
    stream: true,
    lexer: require('./grammars/DbQueryLexer').DbQueryLexer,
    parser: require('./grammars/DbQueryParser').DbQueryParser,
    visitor: require('./visitors/query').Visitor,
    reducer: require('./reducer').Reducer,
  },
  {
    endpoint: 'insert',
    method: 'POST',
    lexer: require('./grammars/DbInsertLexer').DbInsertLexer,
    parser: require('./grammars/DbInsertParser').DbInsertParser,
    visitor: require('./visitors/insert').Visitor,
    reducer: require('./reducer').Reducer,
  },
  {
    endpoint: 'update',
    method: 'PATCH',
    lexer: require('./grammars/DbUpdateLexer').DbUpdateLexer,
    parser: require('./grammars/DbUpdateParser').DbUpdateParser,
    visitor: require('./visitors/update').Visitor,
    reducer: require('./reducer').Reducer,
  },
  {
    endpoint: 'delete',
    method: 'DELETE',
    lexer: require('./grammars/DbDeleteLexer').DbDeleteLexer,
    parser: require('./grammars/DbDeleteParser').DbDeleteParser,
    visitor: require('./visitors/delete').Visitor,
    reducer: require('./reducer').Reducer,
  },
];

export default handlers;
