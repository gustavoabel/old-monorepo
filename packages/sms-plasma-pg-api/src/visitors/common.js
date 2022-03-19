const DbCommonVisitor = require('../grammars/DbCommonVisitor').DbCommonVisitor;

/**
 * Used the class composition described in https://alligator.io/js/class-composition/
 * Regular subclassing will not work with TypeError: Class constructor CommonVisitor
 * cannot be invoked without 'new' (this is due to ES5 and ES6 incompatibilities)
 */
const CommonVisitor = (superclass) =>
  class extends superclass {
    constructor() {
      super();
      DbCommonVisitor.call(this);

      this.schema = null;
      this.baseTable = null;
      this.filter = null;
      this.returning = null;

      return this;
    }

    visitPath(ctx) {
      this.schema = ctx.schema.getText();
      var table = `"${ctx.baseTable.tableName.getText()}"`;
      var alias = ctx.baseTable.aliasName ? ctx.baseTable.aliasName.getText().replace(/'/g, '"') : table;
      this.baseTable = { table: table, alias: alias };
    }

    visitWhereClause(ctx) {
      var result = this.visitChildren(ctx)[0];
      this.filter = result;
    }

    visitArgKey(ctx) {
      return ctx.getText();
    }

    visitConstant(ctx) {
      return ctx.getText();
    }

    visitConstantList(ctx) {
      return ctx.getText();
    }

    visitColumn(ctx) {
      return ctx.tableAlias
        ? `${ctx.tableAlias.getText().replace(/'/g, '"')}.${ctx.colName.getText()}`
        : `${this.baseTable.alias}.${ctx.colName.getText()}`;
    }

    visitFunctionCall(ctx) {
      var result = this.visitChildren(ctx.fnArg)[0];
      return `${ctx.fn.text}(cast((${result}) as numeric))`;
    }

    visitLogicalExpression(ctx) {
      var result = this.visitChildren(ctx);
      return result
        .filter((element) => {
          return element !== undefined && element.toString().length > 0;
        })
        .join(` ${ctx.op.getText().toLowerCase()} `);
    }

    visitNotExpression(ctx) {
      var result = this.visit(ctx.exp)[0];
      return `not(${result})`;
    }

    visitNullExpression(ctx) {
      const op = ctx.op.getText();
      var result = this.visit(ctx.exp)[0];

      const formattedOp = op.toLowerCase() === 'isnull' ? op : 'notnull';

      return `${result} ${formattedOp}`;
    }

    visitComparisonExpression(ctx) {
      var lval = this.visit(ctx.left)[0];
      var rval = this.visit(ctx.right)[0];
      var left = !isNaN(lval) ? `(${lval})::numeric` : lval;
      var right = !isNaN(rval) ? `(${rval})::numeric` : rval;
      return `${left} ${this.visit(ctx.op)} ${right}`;
    }

    visitComparisonOperator(ctx) {
      var text = ctx.getText();
      if (text == '~') {
        text = 'like';
      }
      if (text == '.') {
        text = 'in';
      }
      return text;
    }

    visitLtreeOperator(ctx) {
      return ctx.getText();
    }

    visitMathExpression(ctx) {
      var lval = this.visit(ctx.left)[0];
      var rval = this.visit(ctx.right)[0];
      var left = !isNaN(lval) ? `(${lval})::numeric` : lval;
      var right = !isNaN(rval) ? `(${rval})::numeric` : rval;

      return `${left} ${ctx.op.getText()} ${right}`;
    }

    visitUnaryExpression(ctx) {
      var result = this.visit(ctx.exp)[0];
      return `${ctx.op.getText()}${result}`;
    }

    visitParenthesisExpression(ctx) {
      var result = this.visit(ctx.exp)[0];
      return `(${result})`;
    }

    visitReturningOption(ctx) {
      var returning = ctx.getText();
      if (returning.toLowerCase().startsWith('rows(')) {
        returning = returning.substring('rows('.length, returning.length - 1);
      }
      this.returning = returning;
      return returning;
    }
  };

exports.CommonVisitor = CommonVisitor;
