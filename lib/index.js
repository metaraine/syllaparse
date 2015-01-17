(function() {
  var authorYearTitle, classTitle, recommended, required, start;

  start = /^\s*Course Outline\s*$/m;

  classTitle = /^(\d+\/\d+)\s+/m;

  required = /^\s*(Required)|(Required readings)|(Readings)[:]?\s*$/i;

  recommended = /^\s*Recommended[:]?\s*$/i;

  authorYearTitle = /^(.*?)\s*\((\d{4})\)\.?\s*(.*)\s*$/i;

  module.exports = function(input) {
    var classDate, line, matches, reading, readings, _i, _len, _ref;
    matches = start.exec(input);
    if (!matches) {
      throw new Error('Could not find start token: "Course Outline"');
    }
    input = input.slice(matches.index + matches[0].length);
    input.replace(required, '');
    readings = [];
    recommended = false;
    classDate = null;
    _ref = input.split(/\s*\n\s*/);
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      line = _ref[_i];
      if (matches = classTitle.exec(line)) {
        classDate = matches[1];
      } else if (matches = authorYearTitle.exec(line)) {
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
      }
    }
    return readings;
  };

}).call(this);
