const DbDeleteVisitor = require('../grammars/DbDeleteVisitor').DbDeleteVisitor;
const CommonVisitor = require('./common').CommonVisitor;

/**
 *
 */
class Visitor extends CommonVisitor(DbDeleteVisitor) {
  constructor() {
    super();
    DbDeleteVisitor.call(this);

    return this;
  }

  start(ctx) {
    // call visitRequest to visit the whole tree
    this.visitRequest(ctx);

    // prepare 'from' clause
    var from = `from ${this.schema}.${this.baseTable.table} ${this.baseTable.alias}`;

    // prepare filter
    var where = this.filter ? `where ${this.filter}` : '';

    // and finally prepare the sql statement
    var sql;

    this.returning = (this.returning || 'none').toLowerCase();
    if (this.returning == 'none') {
      // returning empty response
      sql = `delete ${from} ${where}`;
    } else if (this.returning == 'count') {
      // returning the number of deleted rows
      sql = `with deleted as (delete ${from} ${where} returning *) select count(*) from deleted`;
    } else if (this.returning == 'rows') {
      // returning delete rows, all columns
      sql = `delete ${from} ${where} returning *`;
    } else {
      // assumed to be a column name csv
      sql = `delete ${from} ${where} returning ${this.returning}`;
    }
    return sql;
  }
}

exports.Visitor = Visitor;
