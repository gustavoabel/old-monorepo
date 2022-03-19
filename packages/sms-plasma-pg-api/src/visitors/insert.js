const DbInsertVisitor = require('../grammars/DbInsertVisitor').DbInsertVisitor;
const CommonVisitor = require('./common').CommonVisitor;

/**
 *
 */
class Visitor extends CommonVisitor(DbInsertVisitor) {
  constructor() {
    super();
    DbInsertVisitor.call(this);

    return this;
  }

  start(ctx) {
    // call visitRequest to visit the whole tree
    this.visitRequest(ctx);

    // prepare 'into' clause
    var into = `${this.schema}.${this.baseTable.table}`;

    // and finally prepare the sql statement
    var sql;

    this.returning = (this.returning || 'none').toLowerCase();
    if (this.returning == 'none') {
      // returning empty response
      sql = `insert into ${into} (__keys__) values (__values__)`;
    } else if (this.returning == 'count') {
      // returning the number of deleted rows
      sql = `with inserted as (insert into ${into} (__keys__) values (__values__) returning *) select count(*) from inserted`;
    } else if (this.returning == 'rows') {
      // returning delete rows, all columns
      sql = `insert into ${into} (__keys__) values (__values__) returning *`;
    } else {
      // assumed to be a column name csv
      sql = `insert into ${into} (__keys__) values (__values__) returning ${this.returning}`;
    }
    return sql;
  }
}
exports.Visitor = Visitor;
