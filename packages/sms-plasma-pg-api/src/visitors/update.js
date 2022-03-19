const DbUpdateVisitor = require('../grammars/DbUpdateVisitor').DbUpdateVisitor;
const CommonVisitor = require('./common').CommonVisitor;

/**
 *
 */
class Visitor extends CommonVisitor(DbUpdateVisitor) {
  constructor() {
    super();
    DbUpdateVisitor.call(this);

    return this;
  }

  start(ctx) {
    // call visitRequest to visit the whole tree
    this.visitRequest(ctx);

    // prepare 'table' clause
    var table = `${this.schema}.${this.baseTable.table}`;

    // and finally prepare the sql statement
    var sql;

    this.returning = (this.returning || 'none').toLowerCase();
    if (this.returning == 'none') {
      // returning empty response
      sql = `update ${table} set __keysvalues__ where ${this.filter}`;
    } else if (this.returning == 'count') {
      // returning the number of deleted rows
      sql = `with updated as (update ${table} set __keysvalues__ where ${this.filter} returning *) select count(*) from updated`;
    } else if (this.returning == 'rows') {
      // returning delete rows, all columns
      sql = `update ${table} set __keysvalues__ where ${this.filter} returning *`;
    } else {
      // assumed to be a column name csv
      sql = `update ${table} set __keysvalues__ where ${this.filter} returning ${this.returning}`;
    }
    return sql;
  }
}
exports.Visitor = Visitor;
