(function() {
  var cint, re;

  cint = require('cint');

  re = {
    blankline: /^\s*$/,
    start: /^\s*Course Outline\s*$/m,
    classTitle: /^(\d+\/\d+).*/m,
    required: /^\s*(?:Required)|(?:Required readings)|(?:Readings)[:]?\s*$/i,
    recommended: /^\s*Recommended[:]?\s*$/i,
    authorYearTitle: /^(.*?)\s*\((\d{4})\)\.?\s*(.*?)\s*$/i
  };

  module.exports = function(input) {
    var classDate, line, matches, reading, readings, recommended, _i, _len, _ref;
    matches = re.start.exec(input);
    if (!matches) {
      throw new Error('Could not find start token: "Course Outline"');
    }
    input = input.slice(matches.index + matches[0].length);
    input.replace(re.blankline, '').replace(re.required, '');
    readings = [];
    recommended = false;
    classDate = null;
    _ref = input.split('\n');
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      line = _ref[_i];
      if (matches = re.classTitle.exec(line)) {
        classDate = matches[1];
        recommended = false;
      } else if (re.recommended.exec(line)) {
        recommended = true;
      } else if (matches = re.authorYearTitle.exec(line)) {
        reading = {
          author: matches[1],
          year: +matches[2],
          title: matches[3],
          classDate: classDate
        };
        if (recommended) {
          reading.recommended = true;
        }
        readings.push(reading);
      } else if (readings.length && line.indexOf('\t') === 0) {
        cint.index(readings, -1).title += line.trim();
      }
    }
    return readings;
  };

}).call(this);
