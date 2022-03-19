const JSONStream = require('JSONStream');
const { Parser, Transform } = require('json2csv');

class Reducer {
  reduce(results, format, stream) {
    if (!results.length || format !== 'CSV') return '';

    if (stream) {
      return results[0].pipe(new Transform(undefined, { objectMode: true }));
    } else {
      return new Parser().parse(results);
    }
  }
}
exports.Reducer = Reducer;
