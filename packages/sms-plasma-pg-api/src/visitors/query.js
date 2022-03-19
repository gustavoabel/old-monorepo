const DbQueryVisitor = require('../grammars/DbQueryVisitor').DbQueryVisitor;
const CommonVisitor = require('./common').CommonVisitor;

// used as splitters and joiners
const EMPTY = '';
const DOT = '.';
const INNER = 'INNER';

/**
 *
 */
class Visitor extends CommonVisitor(DbQueryVisitor) {
  constructor() {
    super();
    DbQueryVisitor.call(this);

    this.includedTables = new Map();
    this.joins = [];
    this.selectElements = [];
    this.distinct = false;
    this.groupBy = [];
    this.orderBy = [];
    this.limit = null;

    return this;
  }

  start(ctx) {
    // call visitRequest to visit the whole tree
    this.visitRequest(ctx);

    // prepare 'from' clauses
    var from = ` from ${this.schema}.${this.baseTable.table} ${this.baseTable.alias}`;

    // prepare 'select' clauses
    var select =
      'select ' +
      (this.distinct ? 'distinct ' : '') +
      this.selectElements
        .map((element) => {
          var suffix = element.alias ? ` as ${element.alias}` : EMPTY;
          var text = element.trunc ? `date_trunc('${element.trunc}', ${element.text})` : element.text;
          return `${text}${suffix}`;
        })
        .join();

    // prepare 'inner join' clauses
    var joins =
      EMPTY +
      this.joins
        .map(
          (join) =>
            ` ${join.type} ${join.schema}.${this.includedTables.get(join.alias).table} ${join.alias} on (${
              join.joinFilter ? join.joinFilter : `${join.in} = ${join.out}`
            })`,
        )
        .join(EMPTY);

    // prepare filter
    var where = this.filter ? ` where ${this.filter}` : EMPTY;

    // prepare group by clause
    var group = this.groupBy.length > 0 ? ` group by ${this.groupBy.join()}` : EMPTY;

    // prepare order by clause
    var order = this.orderBy.length > 0 ? ` order by ${this.orderBy.join()}` : EMPTY;

    // prepare limit
    var limit = this.limit ? ` limit ${this.limit}` : EMPTY;

    // and finally prepare the sql statement
    var sql = `${select}${from}${joins}${where}${group}${order}${limit}`;
    return sql;
  }

  visitIncludeTable(ctx) {
    var included = `"${ctx.included.tableName.getText()}"`;

    var table = {
      table: included,
      alias: ctx.included.aliasName ? ctx.included.aliasName.getText().replace(/'/g, '"') : included,
    };

    this.includedTables.set(table.alias, table);

    var schema = this.schema;
    var joinType = this.getJoinText(INNER);

    if (ctx.included.schemaName) {
      schema = ctx.included.schemaName.getText().replace(/\./g, '');
    }

    if (ctx.joinType) {
      joinType = this.getJoinText(ctx.joinType.getText());
    }

    var lval = ctx.joinFilter ? this.visitChildren(ctx.joinFilter) : undefined;
    // out table is the container, in table is contained (refered in inner join)
    var outAlias = ctx.parentCtx.included
      ? ctx.parentCtx.included.aliasName.getText().replace(/'/g, '"')
      : this.baseTable.alias;

    var join = ctx.joinFilter
      ? {
          joinFilter: lval,
          alias: table.alias,
          schema: schema,
          type: joinType,
        }
      : {
          in: ctx.inColumn.tableAlias
            ? `${ctx.inColumn.tableAlias.getText().replace(/'/g, '"')}.${ctx.inColumn.colName.getText()}`
            : table.alias + DOT + ctx.inColumn.colName.getText(),
          out: ctx.outColumn.tableAlias
            ? `${ctx.outColumn.tableAlias.getText().replace(/'/g, '"')}.${ctx.outColumn.colName.getText()}`
            : outAlias + DOT + ctx.outColumn.getText(),
          alias: table.alias,
          schema: schema,
          type: joinType,
        };

    this.joins.push(join);
    this.visitChildren(ctx);
  }

  getJoinText(joinText) {
    var joinNames = { LEFT: 'left join', RIGHT: 'right join', INNER: 'inner join', FULL: 'full join' };

    return joinNames[joinText.toUpperCase()];
  }

  visitSelectElement(ctx) {
    var result = this.visitChildren(ctx.el)[0];
    var element = {
      text: result,
      alias: ctx.aliasName ? ctx.aliasName.getText().replace(/'/g, '"') : null,
      trunc: ctx.part ? ctx.part.getText() : null,
    };
    this.selectElements.push(element);
  }

  visitSelectDistinct(ctx) {
    this.distinct = true;
    this.visitChildren(ctx);
  }

  visitGroupByValue(ctx) {
    this.groupBy.push(ctx.getText());
  }

  visitOrderByValue(ctx) {
    this.orderBy.push(ctx.getText());
  }

  visitLimit(ctx) {
    this.limit = Number(ctx.val.getText());
  }
}
exports.Visitor = Visitor;
