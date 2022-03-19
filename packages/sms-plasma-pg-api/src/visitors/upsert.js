const DbUpsertVisitor = require('../grammars/DbUpsertVisitor').DbUpsertVisitor;

class Visitor extends DbUpsertVisitor {
  constructor() {
    super();
    DbUpsertVisitor.call(this);

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
    return { name: sql.hashCode().toString(), text: sql, values: this.args };
  }

  visitPath(ctx) {
    this.fn = `"${ctx.schema.getText()}".${ctx.fn.getText()}`;
  }

  visitArgValue(ctx) {
    this.args.push(ctx.getText());
  }
}
exports.Visitor = Visitor;
