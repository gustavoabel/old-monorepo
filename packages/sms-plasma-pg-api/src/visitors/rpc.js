const DbRpcVisitor = require('../grammars/DbRpcVisitor').DbRpcVisitor;
const CommonVisitor = require('./common').CommonVisitor;

/**
 *
 */
class Visitor extends CommonVisitor(DbRpcVisitor) {
  constructor() {
    super();
    DbRpcVisitor.call(this);

    this.fn = null;
    this.args = [];

    return this;
  }

  start(ctx) {
    this.visitRequest(ctx);

    var i = 1;
    var keys = this.args
      .map((arg) => {
        return `$${i++}`;
      })
      .join();
    var sql = `select * from ${this.fn}(${keys})`;
    return sql;
  }

  visitPath(ctx) {
    this.fn = `"${ctx.schema.getText()}".${ctx.fn.getText()}`;
  }

  visitArgValue(ctx) {
    this.args.push(ctx.getText());
  }
}
exports.Visitor = Visitor;
